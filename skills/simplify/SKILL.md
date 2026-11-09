---
name: simplify
description: Use Code Simplicity to strictly review recent project changes, propose evidence-backed removals, and wait for user confirmation before editing. Use when asked to simplify, prune, or challenge the value of recently changed code.
---

# Simplify

Apply [Code Simplicity](../principle-code-simplicity/SKILL.md). Establish what the recent work must accomplish and which behavior users and callers rely on. Judge each addition by the confirmed need it serves and the maintenance work it creates.

## Find candidates without editing

1. Use the scope the user specifies. Otherwise start with relevant staged, unstaged, and new files for the current task. If that work is already committed, inspect the recent task commits against a known base. If the range is unclear, start with the latest commit and state the scope. Follow dependencies only as far as needed to judge or verify a candidate.
2. Read the changed paths through their real entry points. For each meaningful addition, identify the requirement, caller, or constraint it serves. Check callers, configuration, tests, and registration or external contracts where applicable. Treat an empty reference search as a lead to investigate, especially for public interfaces and dynamically loaded code.
3. Look for whole options, branches, or layers that can disappear. Review:
   - Unused features, flags, configuration choices, and extension points built for hypothetical needs.
   - Pass-through wrappers, one-purpose abstractions, and interface methods with no demonstrated role.
   - Temporary workarounds, hardcoded values that duplicate a rule or hide an environment assumption, and unreachable fallback paths.
   - Duplicate domain rules or behavior already provided by an existing owner. Merge only when the copies represent the same rule.
   - Code whose upkeep has no demonstrated benefit for users, callers, or maintainers.
4. Classify meaningful candidates as **Proposed removal**, **Keep**, or **Investigate**. For each proposed removal, give an item number, code location, evidence, expected impact, and verification check. Identify any effect on supported behavior and the evidence still needed for uncertain items.
5. Present the findings and stop. Ask the user to explicitly confirm which proposed removals to apply. Leave the workspace untouched during this phase, even if the initial request asks for simplification or removal. If there are no removal candidates, report that and finish.

## Remove and verify after confirmation

Apply only the items the user confirms after seeing the findings. Make the smallest removal or consolidation for each confirmed item and clean up references made obsolete by it. Preserve required behavior and existing user changes. Present newly discovered removal candidates for separate confirmation.

Run focused checks through the normal entry points for affected behavior. Check any relevant alternate inputs or callers touched by the removal. Report the reviewed scope, what was removed and why, material candidates kept or still open, and the checks run with their results.
