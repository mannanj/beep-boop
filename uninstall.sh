#!/bin/bash
# beep-boop uninstaller — removes the hooks added by install.sh and the
# installed files. Leaves all your other hooks and settings untouched.
set -euo pipefail

DEST="$HOME/.claude/beep-boop"
SETTINGS="$HOME/.claude/settings.json"

if [ -f "$SETTINGS" ]; then
  python3 - "$SETTINGS" <<'PYEOF'
import json, sys

path = sys.argv[1]
with open(path) as f:
    settings = json.load(f)

hooks = settings.get("hooks", {})
for event in list(hooks.keys()):
    kept = []
    for entry in hooks[event]:
        # remove our hooks — match the new name and the legacy claude-cues name,
        # so this also cleans up installs made before the rebrand.
        inner = [h for h in entry.get("hooks", [])
                 if "beep-boop" not in h.get("command", "") and "claude-cues" not in h.get("command", "")]
        if inner:
            entry["hooks"] = inner
            kept.append(entry)
    if kept:
        hooks[event] = kept
    else:
        del hooks[event]

with open(path, "w") as f:
    json.dump(settings, f, indent=2)
    f.write("\n")

print("beep-boop: hooks removed from", path)
PYEOF
fi

rm -rf "$DEST"
echo "beep-boop: uninstalled. (State/config at ~/.claude/beep-boop removed.)"
