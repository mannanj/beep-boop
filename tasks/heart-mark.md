# Task — wave-inside-a-heart brand mark (idea, not built)

**Status:** queued (idea, parked) · 2026-06-28
**Files:** `site/index.html` (nav `.brand` SVG), wherever the mark is reused
**Origin:** During the Beep Boop rebrand, the idea came up to evolve the header icon —
take the existing amber **waveform** and nest it **inside a heart** (or similar lovable
container). The user's call: *don't change the icon now, mark it as an idea to play with
later.* So this is parked, not active.

## The idea

The current mark is a small amber oscilloscope waveform next to the wordmark. The wave is
the soul of the product (sound made visible). The Beep Boop rebrand adds a *lovable*
register. A **wave inside a heart** marries the two: what it does (the wave) wrapped in
how it feels (the heart). A clean bridge from "technical instrument" to "Beep Boop."

## If/when we build it

- Keep it **one accent** (phosphor amber `#ffb454`), mono-era simple, line-based — it has
  to sit in a 22×16-ish mono lockup next to `beep boop` and still read at nav size and as
  a favicon.
- The heart should be a **light outline** that *contains* the waveform, not a filled
  emoji heart (filled reads cutesy and fights the restrained aesthetic). The wave stays
  the hero; the heart is a quiet enclosure.
- Try: a heart drawn as a single stroke with the existing `d="M1 8 H4 L6 2 L9 14 L12 4
  L15 11 L17 8 H21"` waveform riding through its middle, clipped to the heart's interior.
- Test at favicon size (16px) — if the wave turns to mush inside the heart, the heart
  loses. The wave must survive.
- Respect `prefers-reduced-motion` and keep it a static mark (the animated scope is the
  hero; the wordmark mark stays calm).

## Guardrail

This is a **delight experiment**, not a mandate. The current waveform mark is good and
shipping. Only adopt the heart if it's unmistakably better at nav size *and* favicon
size. If it cheapens the mark even slightly, keep the plain wave. See `BRAND.md` →
"Mark exploration."

## Out of scope

A full logo system, wordmark redesign, color changes. Just the one mark.
