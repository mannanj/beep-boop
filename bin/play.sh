#!/bin/bash
# claude-cues — gentle sound cues for Claude Code.
# Called by Claude Code hooks: play.sh <event>
#   events:      start | submit | done | permission | error | precompact
#   subcommands: on | off | toggle | status
#
# Design rules:
#   - Fire-and-forget: never block the hook, never fail it (always exit 0).
#   - One personality per session, rotated on `start`.
#   - Missing sound for an event = graceful silence, never borrow a voice.

PLUGIN_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOUNDS_DIR="${CLAUDE_CUES_SOUNDS_DIR:-$PLUGIN_ROOT/sounds}"
STATE_DIR="${CLAUDE_CUES_STATE_DIR:-$HOME/.claude/claude-cues}"
CONFIG_FILE="$STATE_DIR/config"

mkdir -p "$STATE_DIR" 2>/dev/null

# ---- config (KEY=VALUE lines; all optional) --------------------------------
# ENABLED=1|0       master switch (default 1)
# VOLUME=<float>    macOS afplay gain multiplier (default 3.0 — the bundled
#                   tones are mastered quiet; >1 amplifies)
# PERSONALITY=<name>  pin one personality instead of rotating
ENABLED=1
VOLUME=3.0
PERSONALITY=""
[ -f "$CONFIG_FILE" ] && . "$CONFIG_FILE" 2>/dev/null

set_config() { # set_config KEY VALUE — rewrite one key, preserve the rest
  local key="$1" val="$2" tmp="$CONFIG_FILE.tmp.$$"
  grep -v "^${key}=" "$CONFIG_FILE" 2>/dev/null > "$tmp"
  echo "${key}=${val}" >> "$tmp"
  mv "$tmp" "$CONFIG_FILE"
}

# ---- subcommands ------------------------------------------------------------
case "$1" in
  on)     set_config ENABLED 1; echo "claude-cues: on";  exit 0 ;;
  off)    set_config ENABLED 0; echo "claude-cues: off"; exit 0 ;;
  toggle)
    if [ "$ENABLED" = "1" ]; then set_config ENABLED 0; echo "claude-cues: off"
    else set_config ENABLED 1; echo "claude-cues: on"; fi
    exit 0 ;;
  status)
    current="(none yet)"
    [ -f "$STATE_DIR/personality" ] && current=$(cat "$STATE_DIR/personality")
    echo "claude-cues: enabled=$ENABLED volume=$VOLUME personality=$current pin=${PERSONALITY:-none}"
    echo "sounds: $SOUNDS_DIR"
    echo "config: $CONFIG_FILE"
    exit 0 ;;
esac

EVENT="$1"
[ -z "$EVENT" ] && exit 0
[ "$ENABLED" = "1" ] || exit 0
[ -d "$SOUNDS_DIR" ] || exit 0

# ---- personality selection ---------------------------------------------------
list_personalities() {
  local d
  for d in "$SOUNDS_DIR"/*/; do
    [ -d "$d" ] && basename "$d"
  done
}

rotate_personality() {
  local all=() counter=0 idx
  while IFS= read -r p; do all+=("$p"); done < <(list_personalities | sort)
  [ ${#all[@]} -eq 0 ] && return 1
  [ -f "$STATE_DIR/counter" ] && counter=$(cat "$STATE_DIR/counter" 2>/dev/null)
  case "$counter" in (*[!0-9]*|"") counter=0 ;; esac
  idx=$(( counter % ${#all[@]} ))
  echo "${all[$idx]}" > "$STATE_DIR/personality"
  echo $(( (counter + 1) % ${#all[@]} )) > "$STATE_DIR/counter"
  echo "${all[$idx]}"
}

get_personality() {
  if [ -n "$PERSONALITY" ] && [ -d "$SOUNDS_DIR/$PERSONALITY" ]; then
    echo "$PERSONALITY"; return
  fi
  if [ "$EVENT" = "start" ]; then
    rotate_personality
  elif [ -f "$STATE_DIR/personality" ]; then
    cat "$STATE_DIR/personality"
  else
    rotate_personality
  fi
}

# ---- pick + play -------------------------------------------------------------
personality=$(get_personality)
[ -z "$personality" ] && exit 0

dir="$SOUNDS_DIR/$personality/$EVENT"
[ -d "$dir" ] || exit 0

files=()
for f in "$dir"/*.mp3 "$dir"/*.wav "$dir"/*.m4a "$dir"/*.aiff; do
  [ -e "$f" ] && files+=("$f")
done
[ ${#files[@]} -eq 0 ] && exit 0

sound="${files[$(( RANDOM % ${#files[@]} ))]}"

# Best-effort playback, backgrounded and detached so the hook returns instantly.
if command -v afplay >/dev/null 2>&1; then            # macOS
  (afplay -v "$VOLUME" "$sound" >/dev/null 2>&1 &)
elif command -v ffplay >/dev/null 2>&1; then          # Linux w/ ffmpeg
  (ffplay -nodisp -autoexit -loglevel quiet "$sound" >/dev/null 2>&1 &)
elif command -v mpg123 >/dev/null 2>&1; then          # Linux
  (mpg123 -q "$sound" >/dev/null 2>&1 &)
elif command -v paplay >/dev/null 2>&1; then          # Linux / PulseAudio (mp3 needs libsndfile>=1.1)
  (paplay "$sound" >/dev/null 2>&1 &)
fi
# No player found → silent. Never an error.

exit 0
