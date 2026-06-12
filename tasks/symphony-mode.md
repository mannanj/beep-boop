# Task — "Play a symphony" mode (future)

**Status:** queued (idea, not built) · 2026-06-11
**File:** `site/index.html`
**Origin:** While playing with the audition grid, the cues chained together sound genuinely musical — "I realized how fun it sounded and how nice this was to use." Lean into that.

## The idea
A friendly, cartoony **robot-hands button** sitting next to the chime/hum/ping selector, labeled **"Play a symphony"**. Clicking it hands control to an on-screen **hand cursor** that auto-clicks the event buttons (submit, done, permission, error, start, precompact…) in a fast, musical sequence — so the page literally plays a little symphony for you, in the personality you've selected. A 15-second progress bar counts up `1s / 15s` while it performs.

## Behavior spec
- **Trigger:** a button beside `.seg` (chime/hum/ping) with a cartoony, friendly robot-hands icon + text "Play a symphony".
- **Hand cursor:** on click, spawn a hand-cursor element that visually travels to each event button and "clicks" it (button shows its `.sel`/press state on each hit). The real cursor isn't hijacked — it's a decorative animated overlay element moving in screen space.
- **Sequence:** play the six cues in a composed, rhythmic order (not random) — fast and consecutive so it reads as a melody, e.g. start → submit → submit → done → permission → submit → error → done … Tune the timing by ear; submit has 3 variants for melodic variety.
- **Personality-aware:** every cue uses the currently selected voice (`active`). Switching chime/hum/ping changes the symphony's timbre.
- **Timer:** a thin progress bar under the button counting **`Ns / 15s`**, incrementing each second, filling as it plays. Symphony runs ~15s then resets the hand cursor and button to idle.
- **Replayable:** clicking again restarts it. Disable/ignore re-clicks while a performance is in progress (or let it restart cleanly).
- **Sound gate:** requires sound already enabled (same opt-in as the rest of the page); if not enabled, the click enables it first (force), then performs.
- **Accessibility / taste:** respect `prefers-reduced-motion` (skip the flying-hand animation, still play audio + timer). Keep it tasteful, not annoying — it's a one-shot delight, not a loop.

## Implementation notes
- Reuse existing `play(ev, {force:true})` and the selected `active` voice. No new audio assets needed.
- Hand cursor = an absolutely-positioned emoji/SVG hand; animate via `transform: translate()` with CSS transitions or `requestAnimationFrame`, targeting each event button's `getBoundingClientRect()`.
- Drive the sequence with an array of `{ev, atMs}` steps and `setTimeout`s (or one rAF clock) so audio + hand-move + button-press flash + timer stay in sync.
- The visualizer already reacts to live audio via the AnalyserNode — the symphony will make it dance for free.

## Out of scope
Backend, recording/export, MIDI. Pure front-end delight on the one file.
