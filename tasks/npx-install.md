# Task — make `npx skills add mannanj/claude-cues` actually work

**Status:** queued (UI shipped, mechanism NOT built) · 2026-06-27
**Files:** `site/index.html` (hero install box), repo root (needs `package.json` / publish), `install.sh`
**Origin:** The landing page hero now shows `$ npx skills add mannanj/claude-cues` to match the taste-skill reference UI exactly. The command is **display-only right now** — it is not yet a real, working install path. This task is to make it real (or swap it for the right real command).

## The problem
`npx skills add <user>/<repo>` is the install UX from `Leonxlnx/taste-skill`. But:
- **taste-skill is a SKILL** (a `SKILL.md` folder dropped into `~/.claude/skills/`).
- **claude-cues is a hooks-based PLUGIN**: it must copy `bin/play.sh` + the `sounds/` folder under `~/.claude/`, AND merge six hook entries (SessionStart, UserPromptSubmit, Stop, PermissionRequest, PostToolUseFailure, PreCompact) into `~/.claude/settings.json` (see `install.sh`).

So it is unverified whether the `skills` CLI can install a plugin that needs hook/settings wiring, or whether it only handles SKILL.md skills. **Resolve this before trusting the displayed command.**

## To figure out (research, was interrupted before finishing)
1. Identify the npm package behind `npx skills ...` (exact name, repo, maintainer, latest version).
2. What does `skills add <user>/<repo>` actually do? Does it clone the repo and copy files into `~/.claude/skills/`? Does it run a repo install script? Does it ever touch `~/.claude/settings.json`?
3. **Key question:** can it wire up hooks + copy the `sounds/` folder, or is it skills-only? If skills-only, `npx skills add mannanj/claude-cues` will NOT correctly install claude-cues.

## Likely outcomes / options
- **Option A — publish our own npx CLI.** Add a root `package.json` with `bin: { "claude-cues": "bin/cli.js" }` and a `files` allowlist (ship `bin/`, `sounds/`, `install.sh`). Write `bin/cli.js` (Node) that reimplements `install.sh`'s logic from the package's own directory (copy to `~/.claude/claude-cues/`, merge the six hooks into `~/.claude/settings.json` with a backup, idempotently). Then the real one-liner is **`npx claude-cues`** (and `npx claude-cues uninstall`). Check name availability: `npmjs.com/package/claude-cues`; fall back to `@mannanj/claude-cues` (then the command is `npx @mannanj/claude-cues`). Publish with `npm publish` (needs the user's npm login).
- **Option B — if the `skills` CLI does support arbitrary repos / plugins**, restructure the repo so `skills add mannanj/claude-cues` triggers the hook wiring (e.g. via whatever manifest/postinstall convention that CLI expects), and keep the displayed command as-is.
- **Option C — a hosted one-liner** (`curl -fsSL https://claude-cues.pages.dev/install.sh | bash`) as an immediate real fallback if neither A nor B is ready. Less ideal (curl-pipe-bash), but works today and is a single line.

## Decision needed
Pick A or B. If A, the hero command must change from `npx skills add mannanj/claude-cues` to `npx claude-cues` (or the scoped form). Update `site/index.html` hero `.cmds` + the `#copy-btn` clipboard string together, and the README install section.

## Acceptance
- Running the displayed command on a clean machine installs claude-cues end to end: sounds present under `~/.claude/`, six hooks merged into `settings.json` (existing hooks preserved, file backed up), audible on the next session.
- `/plugin` install path stays documented as the alternative.
