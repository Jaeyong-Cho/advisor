---
name: great-one-code
description: Apply great-code's implementation and verification standards to exactly one production function or one small uniform operation such as renaming a single symbol across its references. Use for tightly bounded changes, with interface-focused TDD for behavior changes and a dedicated Git worktree.
---

# Great One Code

Complete exactly one small change. Read [Development Standards](../great-code/references/development-standards.md) before implementation; reuse it if already loaded in this task. That reference owns the shared development and verification rules. Read the reference directly without loading the `great-code` entrypoint. The scope rules below take precedence whenever completing dependencies or refactoring would widen this task.

## Choose One Change Unit

State the target, intended result, preserved contracts, and verification before editing. Choose exactly one mode:

| Mode | Allowed production change | Example |
| --- | --- | --- |
| One function | Add or change one named function or method, including its signature and body, with only necessary imports. | Correct a calculation or simplify branches inside `calculateTotal`. |
| One uniform operation | Apply one small, precisely defined transformation consistently across its required locations. | Rename one global symbol and update all references to that same symbol. |

For one-function mode, relevant tests and fixtures may change to verify that function through its existing caller-facing interface. They do not count as extra production functions. Test support must remain focused on this requirement; it is not permission to introduce a framework or reorganize the test suite.

Do not create additional production helpers, alter another function's behavior, redesign models, or change callers to accommodate a new signature in one-function mode. A newly added function must be usable through the existing structure without additional production changes or unfinished wiring. Count nested functions and methods separately; changing one containing class or file does not make its functions a single target.

For one-operation mode, define the transformation by its semantic target and rule, not by the number of files. For a global rename, identify one symbol, its old name, and its new name. Update its declaration and all actual references, including relevant tests, documentation, or configuration that refer to it. Use symbol-aware tooling when available and inspect dynamic or string-based references separately. Preserve unrelated symbols with the same spelling. Do not bundle multiple renames, behavior changes, formatting sweeps, or nearby cleanup into the operation.

"Improve validation everywhere" and "refactor the module" are not uniform operations: they require independent behavior or design decisions. Several small tasks do not become one task because they share a file or goal.

## Workflow

1. **Inspect and bound the task.** Read the relevant contracts and call sites, identify the selected function or transformation, and reuse existing mechanisms. Confirm that the requested outcome can be completed within the chosen unit. Keep all other improvements outside the task.
2. **Prepare the workspace.** Follow the shared dedicated Git worktree rules before source or test edits. Use the selected worktree for all edits and verification. Outside Git, use the target directory directly.
3. **Verify the starting behavior.** Follow the shared TDD rules for behavior changes and before/after checks for behavior-preserving operations. Keep test and fixture edits focused on the selected unit.
4. **Perform only the selected change.** Apply abstraction levels, narrow interfaces, clear names, and meaningful runtime assertions inside the selected scope. Use existing dependencies. Do not complete another dependency, extract a helper, reorder unrelated functions, split files, or apply Boy Scout cleanup outside the chosen unit merely to satisfy a broader rule.
5. **Review the complete diff.** Check every changed production function and every edited location against the scope. In one-function mode, confirm exactly one production function was added or changed. In one-operation mode, confirm each edit is required by the same transformation and no independent change was included. Apply the shared diff review and measurements within this scope; verify preserved contracts and reference completeness.
6. **Build and verify.** Follow the shared build and interface-test rules. Resolve failures caused by this change within the selected scope.

## When the Scope Is Insufficient

If the required behavior, integration, verification setup, or metric correction needs another production function or an independent operation, stop that dependent work. Explain the exact additional change needed and why the chosen unit cannot be completed alone. Propose a separately authorized increment or a broader Great Code task; do not switch skills or expand the scope automatically. Continue independent checks that remain useful.

Do not leave TODO implementations, temporary production stubs, broken callers, or a partial global rename and report success. Keep the reviewable work available and state that the task remains incomplete when its necessary scope or verification is unresolved.

## Completion

Provide the shared completion evidence, limited to the selected unit and its affected verification surface. Also report the mode, named function or transformation, and changed production function count for one-function mode, or the transformation's affected locations and reference checks for one-operation mode. Identify any separately needed increment without claiming it was completed.

Stop after this unit has a complete, verified result. Do not automatically proceed to the next improvement.
