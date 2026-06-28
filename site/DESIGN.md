# claude-cues — the landing page, codified

> This file protects `site/index.html`. The page reached its current form by
> **subtraction** — read the git log: `Landing: the wave IS the sound control; drop
> fluff; trim sections`, `revert install to working /plugin commands`, `trim
> sections`. Every commit removed something. The design is already past the point
> where generic best-practice advice improves it. Read this before you "improve" it.

---

## The one idea

**The page is a single playable instrument.** You arrive, you see an amber oscilloscope,
you click it, you hear claude-cues. That one gesture delivers the entire pitch at once:
the problem (you weren't watching), the solution (you heard it anyway), the proof (it's
instant and pleasant), and the how (six moments, three voices). The demo is not a
supporting element on the page. **The demo is the page.**

Everything else — the headline, the install pill, the FAQ — exists only to frame that
one object and get out of its way.

---

## What it is (the design, codified)

**Structure.** Four blocks, two of them content:

```
Nav (wordmark + GitHub)
Hero  →  the instrument (scope + voice selector + six event keys) + headline + install
FAQ   →  five native <details>, one-sentence answers
Footer →  links + "made for people who'd rather listen than look"
```

That is the whole page. Hero, then FAQ, then footer. No "problem" section. No "features"
grid. No "how it works." No proof strip. The shortness is not an omission — it is the
design.

**The hero instrument** (the only thing that matters):
- An amber-phosphor **oscilloscope** that draws the real time-domain waveform of each cue.
- **The scope itself is the on/off control** — you click the wave to enable sound. The
  control and the canvas are the same object. There is no separate "play" button cluttering
  it. This is the move the last commit is named after, and it is the design's high point.
- A segmented **voice selector**: `chime` (bright) · `hum` (warm) · `ping` (dry).
- Six **event keys**: start, submit, permission, error, precompact, done — each a tiny
  labeled button that plays that real cue. This is the complete, scarce control surface.
- After sound is enabled, scrolling fires each section's signature cue once. The page
  auditions itself as you read it.

**Copy.**
- H1: **"Hear it work."** (`work.` in amber). Three words. It is an instruction for the
  instrument you are looking at, and it contains the product's whole soul: *sound* + *it
  functions*.
- Sub: one line — *"claude-cues gives Claude Code a voice. Six soft cues for what it's
  doing, so you can walk away and still know."*
- Install: the two real `/plugin` commands in a dark pill with a quiet COPY.
- Trust meta: one line — `macOS, Linux, ~200KB, zero deps · source`.
- Footer tag: *"made for people who'd rather listen than look."*

**Aesthetic tokens** (one accent, one theme):
- Warm near-black base (`--bg #0c0b0a`), a single phosphor-amber accent (`--amber #ffb454`),
  mono type for everything structural. No second color. No light mode. No webfonts.
- A faint warm vignette so the page reads as a lit device, not a flat slab.

**Engineering identity = product identity.** Single self-contained HTML, inline `<style>`,
one vanilla-JS IIFE, zero dependencies, zero webfonts, ~one screen. The page is built the
way the product is built. That coherence is the point: a ~200KB zero-dep tool gets a
~200KB zero-dep page.

**Progressive enhancement / a11y** (designed in, not patched): works with JS off (native
`<details>`), `prefers-reduced-motion` rests the scope flat, audio is gated behind one
gesture, `focus-visible` rings, the scope is a real keyboard-operable `role="button"`.

---

## Why it works (the principles — transferable)

1. **The demo is the argument.** When a product can demonstrate itself in one interaction,
   prose that re-explains the same thing is dead weight. Do not narrate in words what the
   instrument already proves in a gesture. Words always lose to a working demo.

2. **Confidence over explanation.** The page does not agitate the pain or argue for itself.
   It hands you the instrument and says "Hear it work." A confident product demonstrates;
   an anxious one explains. Restraint reads as high status. Explanation reads as low status.

3. **Form matches message.** The product's virtue is that it is tiny and stays out of your
   way. The page is therefore tiny and stays out of your way. A long scroll-narrative for a
   "minimal, unobtrusive" tool would contradict the thing it is selling.

4. **One object, kept scarce.** There is exactly one place to play the sounds. Scarcity
   makes the instrument feel precious and focused. Duplicating the controls elsewhere would
   cheapen them.

5. **The headline points at the demo.** "Hear it work." is deixis — it refers to the thing
   on screen and tells you what to do with it. A headline that creates an immediate
   action-loop with the hero beats an abstract benefit slogan.

6. **Subtract to the bone; two content sections is a feature.** Every edit to this page
   should remove a word or a section more often than it adds one. The page should end
   smaller than it started.

---

## Case study: why applying the skills made it worse

On 2026-06-27 the page was run through ogilvy, copywriting, copy-editing, stop-slop, and a
design-taste skill, and rebuilt with a "canonical" structure (Hero → Problem → Six-moments
grid → Proof → FAQ). It passed every checklist — 10/10 Playwright, zero em-dashes, clean
pre-flight — and it was **worse in every way**. The attempt is preserved on branch
`landing/copy-revamp-attempt` (commit `bf78fb0`) as the cautionary example.

What went wrong, concretely:

| What the revamp added | What the instrument already did | Net effect |
|---|---|---|
| A "problem" band agitating the walk-away pain | Click the scope and a cue fires while you're not looking — you *feel* the pain solved | Re-stated the pain in weaker words. Condescending. |
| A "six moments" grid, click-to-hear each cue | The six event keys are already click-to-hear | Duplicated the hero's controls and cheapened them |
| A "proof" section: pillars + a numbers strip | The one-line meta + the fact that it just worked | Turned a *felt* fact into a brochure |
| H1 swapped to "Walk away." | — | Traded a demo-pointing instruction for an abstract command to leave |

The deeper failure: **the skills encode the floor, not the ceiling.** Each skill is a
generalization from thousands of average pages, so each one pulls toward the safe average:
"name the pain," "list the features," "show proof," "use the canonical section order." That
average is *below* where this page already was. Applying it regressed a specific, weird,
memorable thing (an oscilloscope you play like an instrument) toward a generic SaaS
template.

And the most uncomfortable part: **the skills themselves said not to do it.** The taste
skill says *"default to fewer sections; earn each one,"* *"the product IS the hero,"*
*"over-building... the user reverted."* The house landing skill says *"copy-first,
subtractive, every word fights for its life."* The right answer was in the skills. The
revamp followed their additive surface (Ogilvy problem-solution, the copywriting section
table) and overrode their hardest, most-specific instruction (cut). It maximized the
rubric and lost the residual — and the residual is taste.

A page that scores 10/10 on every checklist can still be the worse page. The checklist
measures legibility-to-a-rubric. It cannot measure restraint, coherence, or the courage of
a single idea. Those are exactly what this page has and what the "improvement" spent.

---

## Before you change this page (guardrail checklist)

Run this before editing `site/index.html`. If you cannot pass it, do not make the change.

- [ ] **Am I about to add a section?** Default answer is no. The demo already states the
      problem, the solution, the proof, and the how. What would this section say that the
      instrument does not already prove?
- [ ] **Does this duplicate the instrument?** If it lets the user play the sounds a second
      way, cut it. One control surface.
- [ ] **Am I adding because a rubric/skill wants a box checked?** That is a smell, not a
      reason. This design is above the rubric. Skills here are a toolbox to *selectively
      ignore*, not a checklist to maximize.
- [ ] **Does the change make the page longer or shorter?** Bias hard toward shorter. The
      design's whole history is subtraction; keep the vector pointing that way.
- [ ] **Would this contradict "tiny, zero-deps, stays out of your way"?** A heavier page
      undercuts the product's own pitch.
- [ ] **Headline:** does it still point at the demo and carry the product's soul? "Hear it
      work." is load-bearing. Do not trade it for an abstract benefit slogan.
- [ ] **One accent, one theme, mono voice, zero dependencies, single file** — all still true?

The correct mode for this page is **surgical**: tighten a line, fix a bug, improve a
contrast ratio, sharpen one word. Not expansion. If a change feels like "doing a lot," it
is probably the wrong change.
