<p align="center">
  <img alt="beep boop" src="site/beepboop-wordmark.svg" width="360">
</p>

<p align="center">Lovable sounds for coding agents. Soft little chimes, hums, and pings<br>
that tell you what your agent is doing, without looking.</p>

<p align="center">
  <img alt="works with" src="https://img.shields.io/badge/Claude_Code-live-ffb454?labelColor=141210">
  <img alt="codex" src="https://img.shields.io/badge/Codex-soon-3b332c?labelColor=141210">
  <img alt="platform" src="https://img.shields.io/badge/platform-macOS%20%C2%B7%20Linux-000000">
  <img alt="size" src="https://img.shields.io/badge/size-~200KB-blue">
  <img alt="deps" src="https://img.shields.io/badge/dependencies-zero-orange">
  <img alt="code license" src="https://img.shields.io/badge/code-MIT-yellow">
  <img alt="audio license" src="https://img.shields.io/badge/audio-CC0%20%2B%20credited-lightgrey">
</p>

<p align="center">🔊 <strong><a href="https://beeboop.dev">Hear every personality without installing →</a></strong></p>

---

Your coding agent doesn't tell you when it finishes or needs permission. You tab away,
lose the thread, and come back twenty minutes later to a question it asked nineteen
minutes ago.

**Beep Boop fixes that with sound.** Six moments in every session get a soft, distinct
cue, so whether you're heads-down in the terminal or off in another window, your ears
tell you exactly what your agent is up to. A companion, not an alarm.

It's ~200KB of original audio, one shell script, and zero dependencies. No daemon, no
network, no telemetry, and it never blocks your agent; every sound is fire-and-forget.

> **Which agents?** It runs on **Claude Code** today (its hooks fire the cues). The
> engine is agent-agnostic (sounds plus a tiny player), so **Codex** and others are
> next; each just needs its events wired.

## Install

Inside Claude Code:

```
/plugin marketplace add mannanj/beep-boop
/plugin install beep-boop@beep-boop
```

Restart Claude Code (or `/reload-plugins`). That's it. You'll hear it on your next session.

<details>
<summary><strong>No <code>/plugin</code> support, or prefer a script?</strong></summary>

```bash
git clone https://github.com/mannanj/beep-boop.git
cd beep-boop && ./install.sh
```

[`install.sh`](install.sh) is ~80 readable lines: it copies the files to
`~/.claude/beep-boop/` and safely *merges* (never overwrites) six hook
entries into `~/.claude/settings.json`, backing it up first.
Remove everything with [`./uninstall.sh`](uninstall.sh).
</details>

## The sounds

| Hook | When it fires | What you hear |
|---|---|---|
| `SessionStart` | New session | the personality's theme |
| `UserPromptSubmit` | You hit enter | a soft acknowledgment (3 variants) |
| `Stop` | Task done | a completion tone |
| `PermissionRequest` | **Your agent needs you** | a distinct prompt tone |
| `PostToolUseFailure` | Something failed | a gentle low note |
| `PreCompact` | Context compacting | a quiet transition |

## Personalities

Every session gets **one consistent voice**, rotating session to session so it
never goes stale, and never mixes voices mid-session.

| | Character |
|---|---|
| **chime** | crisp, bright, bell-like |
| **hum** | warm, low, rounded |
| **ping** | minimal, dry, precise |
| **oak** | warm, organic, alive: a living tree's voice |

**[Audition all four on the demo page →](https://beeboop.dev)**

### Make your own

A personality is just a folder of mp3s:

```
sounds/<your-name>/{start,submit,done,permission,error,precompact}/*.mp3
```

Drop one in and it joins the rotation automatically. Missing an event folder?
That event is silent for that personality; it never borrows another voice.
PRs with new original (CC0) personalities are very welcome.

## Configure

`/beep-boop:toggle` mutes/unmutes. `/beep-boop:status` shows current state.

Or edit `~/.claude/beep-boop/config`:

```bash
ENABLED=1          # master switch
VOLUME=3.0         # macOS gain multiplier (the tones are mastered quiet)
PERSONALITY=hum    # pin one voice instead of rotating
```

## How it works

- Claude Code [hooks](https://code.claude.com/docs/en/hooks) call one small script: [`bin/play.sh`](bin/play.sh)
- It picks a random sound from the session personality's folder for that event
- Playback is backgrounded (`afplay` on macOS; `ffplay`/`mpg123`/`paplay` on Linux), so the hook returns instantly
- No sound player found, or folder empty? Silent. It can never error your session.

## FAQ

**Does it slow your agent down?** No. The hook backgrounds the player and
returns immediately; there's no daemon and nothing to wait on.

**Can I use my own sounds?** Yes. See [Make your own](#make-your-own).

**Windows?** Not yet (the script no-ops silently). PRs welcome.

**How do I mute just one event?** Delete or empty that event's folder in the
personality, or pin a personality that doesn't define it.

**Will it play over my music?** It plays alongside; the cues are under a second
each and mastered soft.

## Uninstall

Plugin: `/plugin uninstall beep-boop`. Script install: `./uninstall.sh`.

## License

Code is [MIT](LICENSE). The **chime**, **hum**, and **ping** personalities are
original tones synthesized for Beep Boop and dedicated to the public domain under
[CC0](sounds/LICENSE). The **oak** personality is sampled from a recording of a
living cork oak. See [credits](sounds/CREDITS.md) for its source and terms.

Inspired by the walk-away problem everyone has with coding agents, and by
[rubenflamshepherd/starcraft-claude](https://github.com/rubenflamshepherd/starcraft-claude),
which proved how good sound feels in a coding agent (this project ships only
original audio).
