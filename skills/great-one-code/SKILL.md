---
name: great-one-code
description: Implement exactly one production function or one small uniform operation using shared development standards and a dedicated Git worktree. Proceed with the selected function even when the full behavior needs other implementation, and report the remaining dependencies, wiring, and verification explicitly.
---

# Great One Code

Implement exactly one small change. Read [Development Standards](../great-code/references/development-standards.md) before implementation; reuse it if already loaded in this task. That reference owns the shared development and verification rules. Read the reference directly without loading the `great-code` entrypoint. The rules below take precedence over shared requirements to complete the whole dependency path or resolve verification blockers before implementation when those requirements depend on implementation outside this unit.

## Choose One Change Unit

State the target, intended result, preserved contracts, and verification before editing. Choose exactly one mode:

| Mode | Allowed production change | Example |
| --- | --- | --- |
| One function | Add or change one named function or method, including its signature and body, with only necessary imports. | Correct a calculation or simplify branches inside `calculateTotal`. |
| One uniform operation | Apply one small, precisely defined transformation consistently across its required locations. | Rename one global symbol and update all references to that same symbol. |

For one-function mode, relevant tests and fixtures may change to verify the function through the smallest available callable contract. Prefer the existing caller-facing interface when it can reach the function; otherwise test the selected function's contract directly if practical. They do not count as extra production functions. Test support must remain focused on this requirement; it is not permission to introduce a framework or reorganize the test suite.

Do not create additional production helpers, alter another function's behavior, redesign models, or change callers to accommodate a new signature in one-function mode. Implement the selected function's actual logic even when other functions, types, adapters, or caller wiring must be added later for the whole behavior to work. Use established dependency contracts and record missing implementations; do not replace them with production stubs, hardcoded success results, or TODO bodies. Count nested functions and methods separately; changing one containing class or file does not make its functions a single target.

For one-operation mode, define the transformation by its semantic target and rule, not by the number of files. For a global rename, identify one symbol, its old name, and its new name. Update its declaration and all actual references, including relevant tests, documentation, or configuration that refer to it. Use symbol-aware tooling when available and inspect dynamic or string-based references separately. Preserve unrelated symbols with the same spelling. Do not bundle multiple renames, behavior changes, formatting sweeps, or nearby cleanup into the operation.

"Improve validation everywhere" and "refactor the module" are not uniform operations: they require independent behavior or design decisions. Several small tasks do not become one task because they share a file or goal.

## Workflow

1. **Inspect and bound the task.** Read the relevant contracts and call sites, identify the selected function or transformation, and reuse existing mechanisms. Define the selected function's responsibility separately from the full behavior. Identify implementation outside this unit that the full behavior will need, then proceed with the selected function. Keep other production changes outside the task.
2. **Prepare the workspace.** Follow the shared dedicated Git worktree rules before source or test edits. Use the selected worktree for all edits and verification. Outside Git, use the target directory directly.
3. **Verify the starting behavior.** Follow the shared TDD rules for behavior changes whenever the selected contract can be executed, and before/after checks for behavior-preserving operations. If missing implementation outside the function prevents execution, attempt the relevant checks, record the exact blocker, and continue implementing the function. An unresolved import, compilation error, or missing dependency is not behavioral RED evidence; do not claim a demonstrated TDD cycle. Keep test and fixture edits focused on the selected unit.
4. **Perform only the selected change.** Apply abstraction levels, narrow interfaces, clear names, and meaningful runtime assertions inside the selected scope. Use existing dependencies. Do not complete another dependency, extract a helper, reorder unrelated functions, split files, or apply Boy Scout cleanup outside the chosen unit merely to satisfy a broader rule.
5. **Review the complete diff.** Check every changed production function and every edited location against the scope. In one-function mode, confirm exactly one production function was added or changed. In one-operation mode, confirm each edit is required by the same transformation and no independent change was included. Apply the shared diff review and measurements within this scope; verify preserved contracts and reference completeness.
6. **Build and verify.** Follow the shared build and interface-test rules as far as the available implementation allows. Fix defects inside the selected function. Record missing dependencies and wiring that prevent the build or integration checks; preserve the implementation for review rather than abandoning it or adding other production functions. Distinguish verified function behavior from full behavior that remains unavailable or unverified.

## Report Remaining Implementation

Needing more than one function to make the whole behavior work is expected in one-function mode. Finish the selected function to the extent supported by known requirements, keep its reviewable changes, and list the remaining implementation. Do not stop solely because the full dependency path cannot fit this unit, and do not expand the scope automatically.

For each remaining element, state its location or intended owner, what it must implement, its known input/output and failure contract, and how it connects to the selected function. Separate missing functions or types, concrete dependency implementations, caller wiring, and checks that cannot yet run. Give the necessary implementation order when dependencies determine it, and identify one suitable next increment without executing it.

If a required contract or user-owned decision is genuinely unspecified, ask only for that missing decision and continue independent work that is already defined. Report metric corrections that require another function or operation as remaining work rather than claiming compliance or widening the task.

The selected function may be implemented while the use case is still incomplete. State both statuses explicitly, including any build or runtime failure caused by the remaining implementation. Do not claim the full behavior works, hide failures, or claim verification that did not run. One-operation mode still requires completing the chosen transformation consistently; a partial global rename is not a completed operation.

## Completion

Provide the shared completion evidence, limited to the selected unit and its available verification surface. Also report the mode, named function or transformation, and changed production function count for one-function mode, or the transformation's affected locations and reference checks for one-operation mode. State separately whether the function's implementation is finished, which checks passed or could not run, and whether the full behavior can currently work. Include the remaining implementation list above; say explicitly when none remains.

Stop after implementing this unit, running the checks currently possible, and reporting the remaining elements. Do not automatically implement them or proceed to the next improvement.
