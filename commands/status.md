---
description: Show claude-cues status (enabled, volume, current personality)
allowed-tools: Bash("${CLAUDE_PLUGIN_ROOT}/bin/play.sh":*)
---

Run this exact command and report its output to the user:

```
"${CLAUDE_PLUGIN_ROOT}/bin/play.sh" status
```

If the user asked to change something (volume, pinning a personality, disabling), edit `~/.claude/claude-cues/config` accordingly. Valid keys: `ENABLED=1|0`, `VOLUME=<float>` (macOS gain multiplier, default 3.0), `PERSONALITY=<chime|hum|ping>` (pin instead of rotating).
