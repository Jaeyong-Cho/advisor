---
name: verify-advisor
description: Verify advisor setup and Pi runtime support in an isolated HOME, including skill installation, subagents, reruns, and preserved evidence.
disable-model-invocation: true
---

# Verify advisor

Verify the real advisor setup and Pi runtime scripts without modifying the real user environment.

## Launch

Run from the advisor repository root. Define an evidence directory and start a clean isolated run:

```bash
REPO_ROOT="$(pwd)"
TMUX_REPO_ROOT="${TMUX_REPO_ROOT:-$REPO_ROOT/../tmux-conf}"
RUN_ROOT="${VERIFY_RUN_ROOT:-$REPO_ROOT/.verify/verify-advisor}"
SCRATCH="$RUN_ROOT/work"
EVIDENCE="$RUN_ROOT/evidence"
rm -rf "$SCRATCH"
mkdir -p "$SCRATCH/home" "$SCRATCH/skills" "$SCRATCH/bin" "$EVIDENCE"
```

The scratch HOME, target directory, and fake command directory are disposable. The evidence directory survives cleanup.

## Doctor

Confirm the real prerequisites and source entry points:

```bash
command -v bash
command -v node
command -v rsync
test -f "$REPO_ROOT/setup.sh"
test -f "$REPO_ROOT/install-pi.sh"
test -f "$REPO_ROOT/bin/install-pi-subagent"
test -d "$REPO_ROOT/skills"
test -d "$REPO_ROOT/agents"
test -d "$REPO_ROOT/config"
test -d "$TMUX_REPO_ROOT/bin"
```

Record the command output and failures in `$EVIDENCE/doctor.log`.

## Drive

### Install advisor skills and bins

```bash
HOME="$SCRATCH/home" bash "$REPO_ROOT/setup.sh" pi "$SCRATCH/skills" \
  >"$EVIDENCE/setup-first.log" 2>&1

for path in "$SCRATCH/skills"/*; do
  [ -d "$path" ] || continue
  basename "$path"
done | sort >"$EVIDENCE/target-skills-first.txt"
find "$SCRATCH/skills" -type f -print | sort >"$EVIDENCE/target-files-first.txt"

test -L "$SCRATCH/home/.local/bin/install-pi-subagent"
test "$(readlink "$SCRATCH/home/.local/bin/install-pi-subagent")" = "$REPO_ROOT/bin/install-pi-subagent"
test -L "$SCRATCH/home/.local/bin/uninstall-pi-subagent"
```

### Install Pi runtime with a fake Pi command

The fake command prevents network and real Pi settings changes while exercising the advisor installer:

```bash
cat >"$SCRATCH/bin/pi" <<'PI'
#!/usr/bin/env bash
set -euo pipefail
printf '%s\n' "$*" >> "${FAKE_PI_LOG:?}"
case "${1:-}" in
  --list-models)
    printf 'provider model\nopenai-codex gpt-5.6-luna\n'
    ;;
  install|uninstall) ;;
  *) ;;
esac
PI
chmod +x "$SCRATCH/bin/pi"

FAKE_PI_LOG="$EVIDENCE/pi.log" \
PI_AGENT_DIR="$SCRATCH/home/.pi/agent" \
PATH="$SCRATCH/bin:$PATH" \
bash "$REPO_ROOT/install-pi.sh" >"$EVIDENCE/install-pi.log" 2>&1

test -f "$SCRATCH/home/.pi/agent/settings.json"
test -f "$SCRATCH/home/.pi/agent/models.json"
test -f "$SCRATCH/home/.pi/agent/open-tui.json"
test "$(grep -c '^install npm:' "$EVIDENCE/pi.log")" = 7
grep -q '1000000' "$SCRATCH/home/.pi/agent/models.json"
```

### Install Pi subagents with the fake Pi command

```bash
printf '\n\n' | \
FAKE_PI_LOG="$EVIDENCE/pi.log" \
PI_AGENT_DIR="$SCRATCH/home/.pi/agent" \
PATH="$SCRATCH/bin:$PATH" \
bash "$REPO_ROOT/bin/install-pi-subagent" >"$EVIDENCE/install-subagents.log" 2>&1

test -f "$SCRATCH/home/.pi/agent/.installed-pi-subagents"
test "$(wc -l < "$SCRATCH/home/.pi/agent/.installed-pi-subagents" | tr -d ' ')" = 4
for agent in researcher scout reviewer worker; do
  test -f "$SCRATCH/home/.pi/agent/agents/$agent.md"
done
grep -q 'git:github.com/Jaeyong-Cho/pi-interactive-subagents' "$EVIDENCE/pi.log"
```

### Repeat setup and check ownership

```bash
HOME="$SCRATCH/home" bash "$REPO_ROOT/setup.sh" pi "$SCRATCH/skills" \
  >"$EVIDENCE/setup-second.log" 2>&1

for path in "$SCRATCH/skills"/*; do
  [ -d "$path" ] || continue
  basename "$path"
done | sort >"$EVIDENCE/target-skills-second.txt"
find "$SCRATCH/skills" -type f -print | sort >"$EVIDENCE/target-files-second.txt"

for command in tmux-split ts3 ts4 ts5 tnew ta tk tp; do
  test -x "$TMUX_REPO_ROOT/bin/$command"
done
test ! -e "$REPO_ROOT/bin/tmux-split"
```

## Evidence

The run passes when all of these checks succeed:

```bash
diff -u "$EVIDENCE/target-skills-first.txt" "$EVIDENCE/target-skills-second.txt"
diff -u "$EVIDENCE/target-files-first.txt" "$EVIDENCE/target-files-second.txt"
diff -u <(for path in "$REPO_ROOT/skills"/*; do
  [ -d "$path" ] || continue
  basename "$path"
done | sort) "$EVIDENCE/target-skills-second.txt"
while IFS= read -r skill; do
  test -f "$SCRATCH/skills/$skill/SKILL.md"
done < "$EVIDENCE/target-skills-second.txt"
test ! -d "$SCRATCH/skills/skills"
! grep -R -E 'workspace/skills|~/workspace/skills' "$SCRATCH/skills"
```

Preserve logs, inventories, Pi settings, manifests, and command results under `$EVIDENCE`. These artifacts prove the real setup behavior and isolated reruns.

The Pi question-extension behavior is counted only when the fake-Pi activation checks pass. Interactive TUI behavior remains a separate real-host feature and must not be reported as passing from fake command tests.

## Cleanup

Remove only scratch state created by this run:

```bash
rm -rf "$SCRATCH"
```

Do not remove `$EVIDENCE`; it is the verification record. Do not kill processes by name or modify the real HOME.

## Helpers

- `REPO_ROOT` — advisor repository root; run this skill from that directory.
- `TMUX_REPO_ROOT` — tmux repository root; defaults to `../tmux-conf`.
- `VERIFY_RUN_ROOT` — optional override for the run and evidence directory.
- `SCRATCH` — disposable HOME, target, and fake command directory under `VERIFY_RUN_ROOT/work`.
- `EVIDENCE` — persistent logs and inventories under `VERIFY_RUN_ROOT/evidence`.
- Feature map: `features/README.md`.
