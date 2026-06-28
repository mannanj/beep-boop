# Task — `handpan` personality (future voice, sampled)

**Status:** queued (idea, not built) · 2026-06-28
**Files:** `sounds/handpan/<event>/*.mp3` (new) · then wire-in: `sounds/CREDITS.md`, `README.md` (Personalities table), `commands/status.md`, `BRAND.md` ("voices today" line), optional `site/` voice selector
**Origin:** User wants a second calm, organic voice alongside `oak` — built from **handpan** (hang drum) sounds. Handpans are tuned steel; struck with the hands they give warm, bell-metallic, sustaining tones with a fast soft onset and a long shimmering decay — meditative and unmistakably *played by a person*. Where `oak` is a living plant translated to synth, `handpan` is human hands on metal: the two form a calm, hand-made sub-family distinct from the UI-crisp `chime`/`ping`.

## The idea
A fourth (or fifth, after `oak`) personality: **`handpan`** — warm, resonant, struck-metal tones mapped to the six agent hooks. It should feel hand-played and gentle, never alarm-like. Companion to [[oak]]; together they're the "organic/meditative" end of the rotation, with `chime` (bright) and `ping` (dry) at the "instrument/UI" end.

## Character (one word: *resonant*)
Soft mallet/finger onset → bloom → long metallic shimmer that rings out. Tuned (pick one scale — e.g. D Kurd / Celtic minor — so all six cues are consonant with each other). Pairs tonally with `oak`'s 432Hz feel if tuned near it.

## Event mapping (same six hooks as every personality)
- `start` — the tonic/ding note struck once, soft, ringing open. The "awake" note.
- `submit` ×3 — three different notes of the scale, short taps (~0.35–0.6s) with clipped decay. Melodic variety across the three (low/mid/high degrees).
- `done` — a resolved two-note fall or a tonic strike that rings and settles (~0.9–1.2s).
- `permission` — a suspended interval (e.g. the 2nd or 5th) left hanging, unresolved/questioning (~0.8–1.0s).
- `error` — a low, slightly damped strike (palm-muted feel) — darker but still musical, never harsh (~0.8–1.0s).
- `precompact` — a slow rolled chord / gentle gong-like swell that rises and releases (~1.0–1.5s).

## How to build it (proven pipeline — same as `oak`)
1. **Source** the audio. Options, in order of preference:
   - Self-record or a clearly licensed/CC0 handpan sample pack (cleanest for the CC0 story).
   - Or sample a public handpan performance the way `oak` was sourced (`yt-dlp -f bestaudio <url>`), then cut cues from it. Mannan owns the source call; legal is his to handle (see how `oak` was sourced).
2. **Decode** a working region to mono 44.1k: `ffmpeg -i src -ss <a> -to <b> -ac 1 -ar 44100 -c:a pcm_s16le work.wav`.
3. **Mine** for clean single strikes with good onset + ring. Handpans are ideal here — discrete struck notes are easy to isolate (silencedetect between hits). Render `showspectrumpic`/`showwavespic` to *see* onset sharpness and decay; pick notes by dominant frequency so the set is in-key.
4. **Cut + shape** each cue: trim to a clean onset, apply a short fade-in (1–5ms, keep the attack) and a fade-out tail so it rings out without a click. `afade`.
5. **Master to match the family.** Existing cues sit at **~-6 to -7 LUFS integrated, peak ~0 dBFS**. Peak-normalize each cue to ~-1 dBFS and check LUFS lands near the others so rotation is even (`ebur128=peak=true`). Player applies a global `VOLUME` gain on top.
6. **Encode** mono 44.1k mp3 into `sounds/handpan/<event>/handpan-<event>.mp3` (submit → `handpan-submit-1/2/3.mp3`). The player (`bin/play.sh`) auto-discovers the folder — no code change needed for rotation.

## Wire-in checklist (after the audio exists)
- `sounds/CREDITS.md` — add the personality row + honest source/credit line.
- `README.md` — add to the Personalities table.
- `commands/status.md` — add `handpan` to the `PERSONALITY=<…>` valid-values list.
- `BRAND.md` — update the "voices today" sentence.
- `site/` (optional) — add a voice button to the selector and the cues to `site/sounds/handpan/…` **only if** the landing page plays real samples (verify the site's audio model first — `oak` raised the same question).

## Out of scope
A scale picker / multi-tuning system, MIDI, real-time synthesis. One tasteful sampled voice, six cues, shipped like the others.
