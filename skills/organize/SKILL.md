---
name: organize
description: Organize context documents into category and subcategory directories with an index in each directory, then compact them and replace stale values with the latest supported state. Use when context records have become duplicated, outdated, or hard to find.
---

# Organize

Turn context records into a concise, current handoff organized under `<category>/<sub-category>/`. Read [Guard the Context Window](../principle-guard-the-context-window/SKILL.md) and [Technical Writing](../principle-technical-writing/SKILL.md) before editing. Context documents from [To Context](../to-context/SKILL.md) start in the current directory by default; use that directory as the organization root unless the user specifies another.

## Steps

1. **Select the records.** Use the files the user names; otherwise find `*-context-*.md` in the organization root and existing category/subcategory directories. Group records by goal or workstream so unrelated contexts remain separate. For overlapping records, use the user-named target or the highest-numbered or latest-dated existing record as the canonical one. A filename selects the output; it does not prove which facts are current.
2. **Choose the paths.** Give each group one primary home at `<category>/<sub-category>/`: a stable broad topic for the category and a specific goal or workstream for the subcategory. Use short lowercase names with hyphens and reuse existing categories before creating new ones. Move the group's context documents into that directory, including superseded records retained as source history; resolve filename collisions without overwriting a file. For a cross-cutting document, choose one primary home and link to it from other relevant indexes rather than copying it.
3. **Extract current claims.** Identify the goal, decisions, constraints, current state, completed work, verification results, risks, open questions, and next actions. Keep each claim's source and effective date, commit, or observation when available. Inspect linked code or artifacts only where a claim's current value matters.
4. **Resolve conflicts.** For user-owned decisions, use the latest explicit user decision. For repository or runtime facts, use the latest verified observation. Prefer the time of the decision or observation over a file's modification time. Replace superseded values in the active summary with one current value, preserving a short history only when it explains a live constraint. If the latest value cannot be established, mark the conflict unresolved and name the check needed; do not silently choose a winner.
5. **Compact the canonical record.** Group related claims under useful headings such as Goal, Decisions and Constraints, Current State, Verification, Risks and Open Questions, and Next Actions. Deduplicate repeated statements, remove stale plans and narrative that cannot affect the next step, and replace bulky logs or source excerpts with precise paths and evidence links. Keep assumptions distinct from confirmed facts. List the historical records whose active summaries it supersedes; do not delete them.
6. **Write indexes and verify.** Create or update `index.md` in every category and subcategory directory touched. A category index links to its subcategories with a one-line description and current status. A subcategory index links to the canonical context record and its historical sources, naming the current goal, last verified state, and next action without duplicating the full record. Update relative links affected by moves, preserve unrelated index entries, and check that all links resolve. Compare the canonical record against its sources to ensure every active goal, decision, constraint, unresolved risk, and next action remains represented.

## Output

Produce this structure under the organization root:

```text
<category>/index.md
<category>/<sub-category>/index.md
<category>/<sub-category>/{NN}-context-{slug}.md
```

Report the paths created or moved, the records superseded, the conflicts resolved, and any conflict that still needs evidence. The result is done when a future AI can navigate from each category index to the current context, find the next action, and avoid mistaking obsolete values for current ones.
