# Feature: Runtime ownership boundaries

## What it is

The migration keeps advisor/Pi runtime support separate from tmux commands and excludes the legacy skill library.

## How the harness drives it

1. Verify `advisor/bin` contains only advisor/Pi tools.
2. Verify tmux helper commands exist in `~/workspace/tmux-conf/bin`.
3. Verify advisor has no `tmux-split` command.
4. Verify the installed advisor skill target has no nested legacy skill tree.
5. Verify the installed advisor skill content has no `workspace/skills` dependency.

## Observable success

- Pi subagent tools are present in advisor.
- `tmux-split`, `ts3`, `ts4`, `ts5`, `tnew`, `ta`, `tk`, and `tp` are present in `tmux-conf`.
- Tmux helpers are not installed as advisor bins.
- The legacy skill set is absent from the advisor target.

## Gotchas

- `ts5` may invoke external agent launcher commands on `PATH`; those launchers are not owned by advisor.
- Model alias naming remains a separate backlog item.
