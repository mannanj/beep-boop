#!/bin/bash
# beep-boop fallback installer — for Claude Code versions without /plugin,
# or anyone who prefers not to use the plugin system.
#
# What it does (and nothing else):
#   1. Copies this repo's bin/ + sounds/ to ~/.claude/beep-boop/
#   2. Safely MERGES six hook entries into ~/.claude/settings.json
#      (never overwrites your existing hooks; backs the file up first)
#
# Uninstall: ./uninstall.sh  (or see README)
set -euo pipefail

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST="$HOME/.claude/beep-boop"
SETTINGS="$HOME/.claude/settings.json"

command -v python3 >/dev/null 2>&1 || { echo "error: python3 required (used once, to merge settings.json safely)"; exit 1; }

echo "beep-boop: installing to $DEST"
mkdir -p "$DEST"
cp -R "$SRC/bin" "$SRC/sounds" "$DEST/"
chmod +x "$DEST/bin/play.sh"

mkdir -p "$(dirname "$SETTINGS")"
[ -f "$SETTINGS" ] && cp "$SETTINGS" "$SETTINGS.beep-boop-backup" && echo "beep-boop: backed up settings.json -> settings.json.beep-boop-backup"

PLAY="$DEST/bin/play.sh" python3 - "$SETTINGS" <<'PYEOF'
import json, os, sys

path = sys.argv[1]
play = os.environ["PLAY"]

settings = {}
if os.path.exists(path):
    with open(path) as f:
        settings = json.load(f)

hooks = settings.setdefault("hooks", {})

events = {
    "SessionStart":       ("start",      "startup|clear"),
    "UserPromptSubmit":   ("submit",     None),
    "Stop":               ("done",       None),
    "PermissionRequest":  ("permission", None),
    "PostToolUseFailure": ("error",      None),
    "PreCompact":         ("precompact", None),
}

for event, (arg, matcher) in events.items():
    cmd = f'"{play}" {arg}'
    entries = hooks.setdefault(event, [])
    # idempotent: skip if any existing hook already calls beep-boop
    if any("beep-boop" in h.get("command", "")
           for e in entries for h in e.get("hooks", [])):
        continue
    entry = {"hooks": [{"type": "command", "command": cmd}]}
    if matcher:
        entry["matcher"] = matcher
    entries.append(entry)

with open(path, "w") as f:
    json.dump(settings, f, indent=2)
    f.write("\n")

print("beep-boop: hooks merged into", path)
PYEOF

echo "beep-boop: installed. Restart Claude Code (or run /hooks to verify)."
echo "beep-boop: toggle anytime with: $DEST/bin/play.sh toggle"
