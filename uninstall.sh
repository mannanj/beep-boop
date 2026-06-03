#!/bin/bash
# claude-cues uninstaller — removes the hooks added by install.sh and the
# installed files. Leaves all your other hooks and settings untouched.
set -euo pipefail

DEST="$HOME/.claude/claude-cues"
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
        inner = [h for h in entry.get("hooks", []) if "claude-cues" not in h.get("command", "")]
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

print("claude-cues: hooks removed from", path)
PYEOF
fi

rm -rf "$DEST"
echo "claude-cues: uninstalled. (State/config at ~/.claude/claude-cues removed.)"
