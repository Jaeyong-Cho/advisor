# Feature: Pi runtime setup

## What it is

`install-pi.sh` configures Pi settings, model context windows, the Pi UI configuration, and managed Pi extensions. `bin/install-pi-subagent` installs advisor subagents and records the managed manifest.

## How a user reaches it

From `~/workspace/advisor`:

```bash
./install-pi.sh
./bin/install-pi-subagent
```

## How the harness drives it

1. Supply an isolated `PI_AGENT_DIR`.
2. Put a fake `pi` command first on `PATH`.
3. Record package installation requests instead of contacting the network.
4. Run `install-pi.sh` and inspect settings, models, and `open-tui.json`.
5. Feed default answers to the subagent model and thinking prompts.
6. Run `bin/install-pi-subagent` and inspect the four generated agents and manifest.
7. Preserve logs and generated state as evidence.

## Observable success

- Seven advisor-managed Pi packages are requested.
- Pi settings enable regular TUI mode and true color.
- Configured model overrides have a 1M context window.
- The Pi UI configuration is copied.
- Four advisor subagent definitions are rendered.
- The subagent manifest is created.
- No real Pi installation or user HOME is modified.

## Gotchas

- The fake command proves installer state transitions, not real Pi package contents.
- Interactive question-dialog behavior requires a separate real-host verification.
- The installer accepts a short `PI_MODEL` value and normalizes it to the `openai-codex` provider.
