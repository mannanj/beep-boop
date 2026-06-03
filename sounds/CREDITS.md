# Sound credits

All audio in this directory is **original work**, synthesized for claude-cues
(pure-tone synthesis, encoded with ffmpeg). No game audio, no sample packs,
no third-party recordings.

Dedicated to the public domain under **CC0 1.0** — see [LICENSE](LICENSE).
Use them, remix them, ship them in your own projects. Attribution appreciated,
never required.

## The personalities

| Personality | Character | Files |
|---|---|---|
| **chime** | crisp, bright, bell-like | 8 |
| **hum** | warm, low, rounded | 8 |
| **ping** | minimal, dry, precise | 8 |

Each personality covers six events: `start`, `submit` (×3 variants),
`done`, `permission`, `error`, `precompact`.

## Make your own

A personality is just a folder: `sounds/<name>/<event>/*.mp3`.
Drop one in and claude-cues adds it to the session rotation automatically.
PRs with new original (CC0-compatible) personalities are very welcome.
