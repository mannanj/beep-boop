# Bee Boop — the brand, codified

> **Lovable sounds for coding agents.**

This is the north star for what Bee Boop *is* and how it should sound, read, and
feel. It is the companion to [`DESIGN.md`](DESIGN.md), which codifies how
the landing page is *built*. Brand here; page there.

---

## The one line

**Bee Boop gives your coding agent a voice** — six soft little sounds for what it's
doing, so you can look away and still know.

If you only keep one sentence, keep that one.

---

## What it actually is

Your coding agent works in total silence. It starts, thinks, finishes, asks, fails,
waits — and tells you none of it out loud. So you tab to another window, lose the
thread, and come back twenty minutes later to a question it asked nineteen minutes ago.

Bee Boop fixes that with **sound**. Six moments in every session get a soft, distinct
cue. You don't have to watch the terminal anymore — whether you're heads-down in it or
off in another window, your ears tell you what's happening.

The feeling we're selling is not *alert*. It's *company*. A tiny presence humming along
beside you, so the agent feels a little more alive and a lot less silent. **A companion,
not an alarm.**

The hero moment is **"your turn"** — the cue that fires when the agent needs you. That's
the one that saves the dead twenty minutes. Everything else is warmth around it.

---

## The name

We tried naming the *mechanism* (claude-cues, Earshot, Earcon) and the *concept*
(Chirp, Purr, Whistle). All were defensible; all felt like a naming exercise.

**Bee Boop** names the *thing itself*. It is a cue, a notification, a little
personality, and a smile in one word. It doesn't describe the product — it **is** the
product. That's why it won.

It's also bigger than any one tool. "claude-cues" boxed us into Claude Code. "Bee Boop"
belongs to every coding agent.

One deliberate split: we *say* **Bee Boop** (a little bee that boops — warm, with a bit
of character), but the *machine* keeps **`beep-boop`** (the literal sound, a clean
package slug). One name for people, one for code. The site lives at **beeboop.dev**.

### Four forms of the name — use the right one

| Context | Form | Example |
|---|---|---|
| Display / wordmark / lockup | `bee boop` (lowercase, space, mono) | the nav wordmark |
| Prose / titles / sentence | **Bee Boop** | "Bee Boop gives your agent a voice." |
| Technical: package, repo, command, dir | `beep-boop` (lowercase, hyphen) | `/plugin install beep-boop@beep-boop` |
| Domain | **beeboop.dev** (no hyphen, no *p*) | the site |

Never "BeeBoop", "BEE BOOP", or "Bee-Boop" in prose. The display name is **Bee Boop**;
only the technical slug keeps the *p*, as `beep-boop`.

---

## Who it's for

People who run coding agents and would **rather listen than look**. They keep an agent
working while they do something else — read, write, switch windows — and want to know
what it's up to without babysitting a terminal. They like small, crafted, quiet tools
that respect their machine.

---

## Voice & tone

**Lovable, simple, and quietly confident.** We're delightful without being cutesy, and
we never explain what a sound can just *show* you.

- **Warm, not corporate.** "your turn," "all done," "oops" — the way a friendly thing
  beside you would say it.
- **Confident, not anxious.** We don't agitate the pain or argue for ourselves. We hand
  you the instrument and say *hear it work*. A confident product demonstrates; an
  anxious one explains.
- **Tiny, like the product.** Short lines. Few words. The copy is as light and
  unobtrusive as the tool.
- **Lovable ≠ silly.** Charm comes from restraint and precision, not from emoji-spam or
  baby talk. One smile per surface, well placed.

**Say:** *lovable, soft, little, gentle, hear, look away, your turn, sound alive,
company, instrument.*

**Don't say:** *notification system, alerting, observability, ambient awareness layer,
attention gap, productivity, never miss, supercharge, seamless, leverage.* (If it
sounds like an alert utility or a SaaS deck, cut it.)

> Old voice: "Get notified when your agent needs input."
> Bee Boop voice: "Your agent is working. Hear it."

---

## The cues — six moments, four voices

Every session picks **one voice** and keeps it (rotating session to session so it never
goes stale, never mixing mid-session). Each voice covers the same six moments:

| Moment | Technical event | How it *feels* (the warm read) |
|---|---|---|
| Session begins | `start` | "I'm on it." |
| You hit enter | `submit` | "Sent." |
| Task finishes | `done` | "All done." |
| **Needs you** | `permission` | **"Your turn."** ← the hero cue |
| Something failed | `error` | "Oops." |
| Context compacting | `precompact` | "Tidied up." |

The four voices today: **chime** (bright), **hum** (warm), **ping** (dry), and **oak**
(living). The first three are original tones synthesized for Bee Boop and dedicated to the
public domain (**CC0**). **oak** is sampled from a recording of a 460-year-old cork oak's
own bioelectric activity (modular synthesis tuned to 432 Hz) — see `sounds/CREDITS.md` for
the source. New voices are just a folder of mp3s; PRs welcome.

The "warm read" column is for **microcopy and marketing** — it's how the cues feel. The
instrument on the site keeps the precise technical labels, because the instrument is a
precise instrument. Warmth lives in the voice around it, not in renaming its knobs.

---

## Graceful by rule

This is part of the brand, not just the engineering. Bee Boop is **fire-and-forget**:
every cue is backgrounded, never blocks a session, and **goes silent rather than
failing**. No daemon, no network, no telemetry. ~200KB, zero dependencies. A tool made
by someone who respects your terminal. That trustworthiness is a brand asset — lead with
it, never undercut it with a heavier page or a needier voice.

---

## Agents — the honest scope

**North star:** lovable sounds for *any* coding agent. The engine is agent-agnostic —
it's just sounds plus a tiny player. Each agent only needs its events wired up.

**Today:** it ships for **Claude Code** (its hooks fire the cues; install is one
`/plugin` command).

**Next:** **Codex**, then others.

How we show this on surfaces: **a simple badge row** — `Claude Code` live, `Codex` with
a small `soon` pill. That's it. **No "coming soon" paragraphs, no roadmap prose, no
disclaimers.** The badge tells the truth in one glance; we don't apologize for it or
hype it. When an agent is real, its badge goes live. Until then, never claim a cue plays
somewhere it doesn't.

---

## Look & identity

The visual identity is **kept** from claude-cues — it's already excellent and earned its
form by subtraction. The rebrand is a change of *voice and name*, not a redesign.

- **One accent:** phosphor amber `#ffb454` on a warm near-black `#0c0b0a`. No second
  color, no light mode.
- **Mono everything structural.** The page reads like a small lit device.
- **The hero is a playable instrument** — an amber oscilloscope you click to hear the
  cues. The demo is the argument. (See `DESIGN.md`.)
- **Wordmark:** the amber waveform mark + `bee boop` in mono.

### Mark exploration (future, not now)

Idea on the shelf: nest the waveform **inside a heart** — the soul of the product (the
wave) wrapped in the new lovable register (the heart). It's a lovely bridge from the
technical instrument to "Bee Boop." We are **not** changing the current mark yet; it's
captured in [`tasks/heart-mark.md`](tasks/heart-mark.md) to play with later.

---

## Principles (the short list)

1. **A companion, not an alarm.** Sell company and presence, not alerts.
2. **The demo is the argument.** Don't narrate in words what a sound proves in a gesture.
3. **Lovable through restraint.** One smile, well placed, beats ten.
4. **Subtract.** Every surface should fight to get shorter. (The page's whole history is
   cutting; keep the vector pointing that way.)
5. **Tell the truth about agents.** Badge it; don't hype it.
6. **Graceful by rule.** Tiny, silent-on-failure, zero-deps — and proud of it.
