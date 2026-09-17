# Feature: Advisor setup

## What it is

`setup.sh` installs the current advisor skill directories into a flat target directory and links advisor-owned bins into the user's local bin directory.

## How a user reaches it

From `~/workspace/advisor`:

```bash
./setup.sh pi <isolated-skill-target>
```

The verification run supplies a temporary HOME and target directory so the real user configuration remains untouched.

## How the harness drives it

1. Create a clean scratch HOME and target directory.
2. Run `setup.sh pi <target>`.
3. Record the installed skill inventory and files.
4. Confirm advisor bin symlinks point back to the advisor repository.
5. Run the exact setup command again.
6. Compare the inventories and confirm every skill contains `SKILL.md`.
7. Confirm the target is flat and does not contain a nested `skills/` directory.
8. Confirm installed content has no dependency on the legacy `~/workspace/skills` path.
9. Preserve logs and inventories, then remove only scratch state.

## Observable success

- The first setup exits successfully.
- The target skill names match the source skill names.
- Every installed skill has `SKILL.md` at `<target>/<skill>/SKILL.md`.
- Advisor bins are linked from the repository.
- The target does not contain `<target>/skills/`.
- The second setup exits successfully.
- The first and second inventories are identical.
- Evidence remains after scratch cleanup.
- The real HOME and legacy skill installation are unchanged.

## Gotchas

- This feature verifies skill copying and advisor bin linking only.
- Pi package and subagent behavior is covered by `pi-runtime.md`.
- Run from the advisor repository root so `REPO_ROOT` resolves correctly.
