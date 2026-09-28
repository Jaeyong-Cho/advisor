---
name: to-docs
description: Create, read, update, or delete a specified document in an existing logical Book. Only the creator invokes /skill:to-docs directly with an operation and Book path; Advisor must not invoke or delegate it.
disable-model-invocation: true
---

# To Docs

Maintain a creator-owned logical Book through one explicitly requested document operation. The Book explains the intended software from purpose and user-visible behavior down to supporting concepts. A direct invocation delegates only the named operation, not general authority to change its vision or rules.

## Authority and scope

- Run only when the creator directly invokes `/skill:to-docs` with `create`, `read`, `update`, or `delete`, an existing Book directory, and an exact target document path inside it. Resolve relative paths from the working directory and reject paths that escape the Book, including symlink targets. Do not guess the Book location or create or remove the Book root. If the operation, path, or intended change is unclear, ask before writing.
- Never run as an automatic Advisor Action or through a delegated agent. Advisor and its delegates keep the Book read-only. This direct owner invocation is an exception only for the requested operation and the entry-point or references that must change with it.
- Read the Book's entry point and relevant chapters before a change. Preserve current requirements unless the creator explicitly authorizes their replacement. If a requested change conflicts with an existing rule, changes another goal, or would remove the only explanation of an agreed behavior, show the conflict and ask the creator to decide. Do not silently treat newer wording as authority.
- Do not bypass read-only mounts or access controls. If the Book cannot be changed without weakening its protection, stop and let the creator adjust the environment.

## Operations

- **Create.** Require a named path that does not exist and creator-approved intent, such as an approved discussion brief. Add a chapter only if it has a distinct purpose; do not duplicate an existing explanation. Link the new document from the Book's entry point or the appropriate existing chapter.
- **Read.** Read the named document and enough surrounding context to explain its purpose and links. Report what it says and distinguish confirmed Book requirements from interpretations. Make no changes.
- **Update.** Require an existing named document and approved changes. Make the smallest edit that expresses the new intent; preserve valid explanations and links. Update affected references only when needed for consistency.
- **Delete.** Require the creator to explicitly name one existing file for deletion. Inspect incoming links and the requirements it owns. If deletion would orphan an agreed rule or invalidate other chapters, ask how the creator wants those obligations handled before proceeding. Delete only that file and adjust its affected links; never delete the Book root, a directory, or a set selected by a pattern.

For create and update, structure the explanation from why the software exists and what people experience to the supporting concepts and their relationships. State agreed behavior, constraints, delegated implementation choices, and observable completion conditions near the goal they govern. Make objective conditions checkable when practical, but leave contextual judgments explicit. Do not turn suggestions, uncertain decisions, transcripts, or temporary plans into requirements. Include code only if an approved contract or a concrete example needs it. Apply [Technical Writing](../principle-technical-writing/SKILL.md).

## Verify and report

For create, update, or delete, re-read the changed chapters and entry point. Check that links resolve, unrelated rules survive, the selected goal remains coherent, and only the named file and necessary references changed. For read, verify the reported claims against the source. Report the operation, paths read or changed, decisions encoded or removed, open conflicts, and verification limits. Do not implement software or claim a Book goal complete merely because documentation changed.

## Done when

The authorized operation has an evidence-backed result, the Book's structure and existing obligations remain coherent, and no unrelated file or user-owned rule was silently changed. When an ownership conflict or missing input blocks the operation, report the blocker instead of claiming completion.
