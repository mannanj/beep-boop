<h1 align="center">claude-cues 🔉</h1>

<p align="center">Gentle sound cues for Claude Code. Soft chimes, hums, and pings<br>
that tell you what your agent is doing — without looking.</p>

<p align="center">
  <img alt="platform" src="https://img.shields.io/badge/platform-macOS%20%C2%B7%20Linux-000000">
  <img alt="install" src="https://img.shields.io/badge/install-one%20command-brightgreen">
  <img alt="size" src="https://img.shields.io/badge/size-~200KB-blue">
  <img alt="deps" src="https://img.shields.io/badge/dependencies-zero-orange">
  <img alt="code license" src="https://img.shields.io/badge/code-MIT-yellow">
  <img alt="audio license" src="https://img.shields.io/badge/audio-CC0-lightgrey">
</p>

<p align="center">🔊 <strong><a href="https://claude-cues.pages.dev">Hear every personality without installing →</a></strong></p>

---

Claude Code doesn't tell you when it finishes or needs permission. You tab away,
lose the thread, and come back twenty minutes later to a question it asked
nineteen minutes ago.

**claude-cues fixes that with sound.** Six moments in every session get a soft,
distinct cue — so you can walk away and still know exactly what your agent is doing.

It's ~200KB of original audio, one shell script, and zero dependencies.
No daemon, no network, no telemetry, and it never blocks Claude — every sound
is fire-and-forget.

## Install

Inside Claude Code:

```
/plugin marketplace add mannanj/claude-cues
/plugin install claude-cues@claude-cues
```

Restart Claude Code (or `/reload-plugins`). That's it — you'll hear it on your next session.

<details>
<summary><strong>No <code>/plugin</code> support, or prefer a script?</strong></summary>

```bash
git clone https://github.com/mannanj/claude-cues.git
cd claude-cues && ./install.sh
```

[`install.sh`](install.sh) is ~80 readable lines: it copies the files to
`~/.claude/claude-cues/` and safely *merges* (never overwrites) six hook
entries into `~/.claude/settings.json`, backing it up first.
Remove everything with [`./uninstall.sh`](uninstall.sh).
</details>

## The sounds

| Hook | When it fires | What you hear |
|---|---|---|
| `SessionStart` | New session | the personality's theme |
| `UserPromptSubmit` | You hit enter | a soft acknowledgment (3 variants) |
| `Stop` | Task done | a completion tone |
| `PermissionRequest` | **Claude needs you** | a distinct prompt tone |
| `PostToolUseFailure` | Something failed | a gentle low note |
| `PreCompact` | Context compacting | a quiet transition |

## Personalities

Every session gets **one consistent voice**, rotating session to session so it
never goes stale — and never mixes voices mid-session.

| | Character |
|---|---|
| **chime** | crisp, bright, bell-like |
| **hum** | warm, low, rounded |
| **ping** | minimal, dry, precise |

**[Audition all three on the demo page →](https://claude-cues.pages.dev)**

### Make your own

A personality is just a folder of mp3s:

```
sounds/<your-name>/{start,submit,done,permission,error,precompact}/*.mp3
```

Drop one in and it joins the rotation automatically. Missing an event folder?
That event is silent for that personality — it never borrows another voice.
PRs with new original (CC0) personalities are very welcome.

## Configure

`/claude-cues:toggle` mutes/unmutes. `/claude-cues:status` shows current state.

Or edit `~/.claude/claude-cues/config`:

```bash
ENABLED=1          # master switch
VOLUME=3.0         # macOS gain multiplier (the tones are mastered quiet)
PERSONALITY=hum    # pin one voice instead of rotating
```

## How it works

- Claude Code [hooks](https://code.claude.com/docs/en/hooks) call one small script: [`bin/play.sh`](bin/play.sh)
- It picks a random sound from the session personality's folder for that event
- Playback is backgrounded (`afplay` on macOS; `ffplay`/`mpg123`/`paplay` on Linux) — the hook returns instantly
- No sound player found, or folder empty? Silent. It can never error your session.

## FAQ

**Does it slow Claude Code down?** No. The hook backgrounds the player and
returns immediately; there's no daemon and nothing to wait on.

**Can I use my own sounds?** Yes — see [Make your own](#make-your-own).

**Windows?** Not yet (the script no-ops silently). PRs welcome.

**How do I mute just one event?** Delete or empty that event's folder in the
personality — or pin a personality that doesn't define it.

**Will it play over my music?** It plays alongside; the cues are under a second
each and mastered soft.

## Uninstall

Plugin: `/plugin uninstall claude-cues`. Script install: `./uninstall.sh`.

## License

Code is [MIT](LICENSE). All audio in [`sounds/`](sounds/) is original,
synthesized for this project, and dedicated to the public domain under
[CC0](sounds/LICENSE) — see [credits](sounds/CREDITS.md).

Inspired by the walk-away problem everyone has with coding agents, and by
[rubenflamshepherd/starcraft-claude](https://github.com/rubenflamshepherd/starcraft-claude),
which proved how good sound feels in Claude Code (this project ships only
original audio).
