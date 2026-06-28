# Task — make `npx skills add mannanj/beep-boop` actually work

**Status:** queued · research RESOLVED, mechanism NOT built · hero command is currently non-functional · 2026-06-27
**Files:** `site/index.html` (hero install box), repo root (needs `package.json` / publish), `install.sh`
**Origin:** The landing page hero now shows `$ npx skills add mannanj/beep-boop` to match the taste-skill reference UI exactly. The command is **display-only right now** — it is not yet a real, working install path. This task is to make it real (or swap it for the right real command).

## The problem
`npx skills add <user>/<repo>` is the install UX from `Leonxlnx/taste-skill`. But:
- **taste-skill is a SKILL** (a `SKILL.md` folder dropped into `~/.claude/skills/`).
- **beep-boop is a hooks-based PLUGIN**: it must copy `bin/play.sh` + the `sounds/` folder under `~/.claude/`, AND merge six hook entries (SessionStart, UserPromptSubmit, Stop, PermissionRequest, PostToolUseFailure, PreCompact) into `~/.claude/settings.json` (see `install.sh`).

So it is unverified whether the `skills` CLI can install a plugin that needs hook/settings wiring, or whether it only handles SKILL.md skills. **Resolve this before trusting the displayed command.**

## Research findings (RESOLVED 2026-06-27)
Verified directly via npm:
- **`skills` = `vercel-labs/skills`** (v1.5.13, "The open agent skills ecosystem"), repo https://github.com/vercel-labs/skills. `bin: skills -> bin/cli.mjs`.
- **It is SKILL.md-only.** `skills add <source>` installs *skill packages* (folders containing `SKILL.md`) into agent directories by symlink/copy. Evidence from `skills --help`: `init` "creates `<name>/SKILL.md`"; `--skill`, `--full-depth` ("search subdirectories even when a root SKILL.md exists"). It does NOT merge hooks into `~/.claude/settings.json` and does NOT install a sounds folder for a plugin.
- **`beep-boop` has no `SKILL.md`** (it's a hooks plugin: `bin/play.sh` + `sounds/` + 6 hooks). So **`npx skills add mannanj/beep-boop` will not install it** — it would find no skill.
- **`npx beep-boop` also does not work**: no `package.json` in the repo, and `beep-boop` is unpublished on npm (404).

**Conclusion: the hero command `$ npx skills add mannanj/beep-boop` is display-only and non-functional. Go with Option A (publish our own `npx beep-boop`).**

## Likely outcomes / options
- **Option A — publish our own npx CLI.** Add a root `package.json` with `bin: { "beep-boop": "bin/cli.js" }` and a `files` allowlist (ship `bin/`, `sounds/`, `install.sh`). Write `bin/cli.js` (Node) that reimplements `install.sh`'s logic from the package's own directory (copy to `~/.claude/beep-boop/`, merge the six hooks into `~/.claude/settings.json` with a backup, idempotently). Then the real one-liner is **`npx beep-boop`** (and `npx beep-boop uninstall`). Check name availability: `npmjs.com/package/beep-boop`; fall back to `@mannanj/beep-boop` (then the command is `npx @mannanj/beep-boop`). Publish with `npm publish` (needs the user's npm login).
- **Option B — if the `skills` CLI does support arbitrary repos / plugins**, restructure the repo so `skills add mannanj/beep-boop` triggers the hook wiring (e.g. via whatever manifest/postinstall convention that CLI expects), and keep the displayed command as-is.
- **Option C — a hosted one-liner** (`curl -fsSL https://beeboop.dev/install.sh | bash`) as an immediate real fallback if neither A nor B is ready. Less ideal (curl-pipe-bash), but works today and is a single line.

## Decision needed
Pick A or B. If A, the hero command must change from `npx skills add mannanj/beep-boop` to `npx beep-boop` (or the scoped form). Update `site/index.html` hero `.cmds` + the `#copy-btn` clipboard string together, and the README install section.

## Acceptance
- Running the displayed command on a clean machine installs beep-boop end to end: sounds present under `~/.claude/`, six hooks merged into `settings.json` (existing hooks preserved, file backed up), audible on the next session.
- `/plugin` install path stays documented as the alternative.
