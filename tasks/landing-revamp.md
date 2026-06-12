# Task — Landing page full revamp (`site/index.html`)

**Status:** building (spec + build, same session) · 2026-06-11
**File:** `site/index.html` (single self-contained HTML, no build step) · deploys to claude-cues.pages.dev (Cloudflare Pages)
**Assets:** `site/sounds/<personality>/<event>/*.mp3` — personalities `chime|hum|ping`; events `start, submit(×3 variants), done, permission, error, precompact`. All present, CC0.

## Goal
Brand-new design. A living audio **visualizer** as the centerpiece that animates as you scroll. A real **sound selector** (pick personality + audition each individual event cue). **Scroll-triggered cues** that fire once per section, with click-to-replay. Copy cut to the bone — every word fights for its life.

## Requirements

### 1. Concise copy (ruthless)
- H1: **"Walk away."** Sub: one line — "claude-cues gives Claude Code a voice — start, done, blocked, needs you. It calls you back."
- Section heads stay mono `## one-word` (hear it / how / install / faq).
- `how` cards → one tight line each. FAQ answers → one sentence each. No filler, no hedging.

### 2. Visualizer (animated loop, pretty graphics)
- `<canvas>` centerpiece, `requestAnimationFrame` idle loop: smooth multi-sine waveform in accent color + soft radial glow, always animating.
- Scroll position subtly modulates amplitude/phase so the loop feels alive while scrolling (silent — no autoplay needed).
- When a cue plays, route audio through a Web Audio `AnalyserNode` and draw the **real** waveform; ease back to idle when it ends.

### 3. Sound selector
- Segmented control: `chime · hum · ping` (with one-word character under each). Selection drives every cue on the page.
- Event audition grid: `start · submit · done · permission · error · precompact` — click any to hear that exact cue in the selected personality. This is "select individual sounds."

### 4. Scroll + sound behavior (per user)
- Visualizer animates always, **silent**, before any interaction (respects browser autoplay policy).
- Sound is **opt-in**: one "enable sound" click (also satisfies AudioContext unlock).
- After enabled, each major section fires its **signature cue once** when scrolled into view (`IntersectionObserver`, `once`): hero→start, hear→submit, how→done, install→permission, faq→precompact.
- **Click to replay:** clicking a section heading (or the visualizer) replays that section's cue — "click again to experience it again." Cues never auto-repeat; replay is always manual.

### 5. Keep working
- Install box + Copy button, GitHub nav, mute toggle, terminal demo (redesigned, still plays real mp3s on type/enter), FAQ `<details>`, footer.
- All audio paths reuse existing pattern `sounds/{p}/{ev}/{p}-{ev}{-variant}.mp3`, GAIN 3.0, submit picks 1 of 3 variants.

## Verify
- Open in browser (Playwright/webapp-testing): no console errors, canvas animates, enable-sound unlocks, scroll fires each cue once, heading-click replays, selector switches personality, event grid auditions, Copy works, mobile (≤640px) single-column.

## Out of scope
Backend, analytics, new audio. Pure front-end of the one file.
