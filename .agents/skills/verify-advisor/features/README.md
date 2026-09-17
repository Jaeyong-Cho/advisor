# Advisor verification features

Each feature describes one user-visible behavior that `verify-advisor` can drive and observe.

## Initial coverage

- [Advisor setup](./setup.md) — installs current advisor skills and advisor-owned bins into an isolated target and is safe to rerun.
- [Pi runtime](./pi-runtime.md) — exercises Pi package/configuration and subagent installers with a fake Pi command and isolated state.
- [Ownership boundaries](./ownership.md) — confirms tmux helpers live in `tmux-conf` and legacy skills are excluded from advisor installation.

## Deferred coverage

- Interactive Pi question dialog — requires a real interactive Pi host; fake command verification does not prove TUI behavior.
- Cross-agent question adapters — added only after the supported host matrix is decided.
