---
name: no-comments
description: Review a code scope for unnecessary comments, remove accepted comments, and encode real constraints in code or verification.
disable-model-invocation: true
---

# No Comments

Review comments in a bounded code scope. Remove comments that restate code, preserve comments that communicate a real constraint, and encode recurring or enforceable constraints in the structure instead of prose.

## When to Use

Use this action for a specified set of files or a current diff. When no scope is specified, use the current working-tree diff against the repository's base branch.

Apply [Technical Writing](../technical-writing/SKILL.md) to judge whether a comment carries necessary information. Use [Fix Root Causes](../fix-root-causes/SKILL.md) when a comment hides a workaround or a design problem, [Encode Lessons in Structure](../encode-lessons-in-structure/SKILL.md) when a constraint can be enforced, and [Minimize Reader Load](../minimize-reader-load/SKILL.md) to reduce reading burden.

## Steps

1. Define the review scope and inspect the comments and nearby code in context.
2. Review from a fresh perspective. Classify every candidate as one of the following:
   - **Remove:** It restates the code, narrates history without present value, explains an avoidable workaround, or warns about a constraint the code can enforce.
   - **Keep:** It explains a non-obvious external constraint, safety property, trade-off, or decision that code and local verification cannot express.
   - **Investigate:** Its meaning or necessity is unclear. Inspect the symbol, call sites, tests, history, and relevant behavior before deciding.
3. Do not delete a keep without evidence. A comment such as `do not remove` is not evidence by itself. Find the actual constraint and decide whether it can be changed or encoded.
4. For each accepted removal, make the smallest root-cause change in scope. Delete dead paths, use the real API, reduce a needless parameter, or correct the structure instead of adding a symptom guard.
5. Encode an enforceable constraint with the cheapest suitable type, runtime validation, test, or CI check. Delete the comment after the encoding exists and verify it.
6. Verify the changed behavior through [Closed Working Loop](../closed-working-loop/SKILL.md). Record comments kept, removed, or left open with their evidence.

## Output

Leave a review record containing the scope, removed comments, kept comments and their evidence, constraints encoded, open items, and validation performed.

## Done When

Every reviewed comment has an evidence-backed outcome. Removed comments are no longer needed because the code, contract, test, or check communicates or enforces the relevant knowledge. Kept comments describe information that cannot be made clear or enforceable in scope.

## Avoid

- Deleting comments only to reduce their count.
- Treating a `do not remove` comment as proof of a constraint.
- Adding a guard that hides a symptom in place of resolving the stated problem.
- Removing safety or correctness suppressions without understanding the underlying issue.
- Leaving a constraint in prose when a small, practical structural guard can enforce it.
