---
name: great-one-code
description: Implement one function, build target, CI job, cohesive configuration block, or small uniform operation using shared development standards. Proceed with the selected unit even when full behavior needs more implementation, and report remaining dependencies, wiring, and verification.
---

# Great One Code

Implement exactly one small change. Read [Development Standards](../great-code/references/development-standards.md) before implementation; reuse it if already loaded in this task. That reference owns the shared development and verification rules. Read the reference directly without loading the `great-code` entrypoint. The rules below take precedence over shared requirements to complete the whole dependency path or resolve verification blockers before implementation when those requirements depend on implementation outside this unit.

Apply this scope to application code, Makefiles, build systems, CI workflows, automation scripts, and their configuration. Select a native unit of responsibility; do not force system definitions into functions or introduce wrappers just to apply the skill.

## Choose One Change Unit

State the target, intended result, preserved contracts, and verification before editing. Choose exactly one mode:

| Mode | Allowed production change | Example |
| --- | --- | --- |
| One unit | Add or change one function or method with necessary imports, one build target and its recipe, one CI job and its steps, or one configuration block with a single responsibility. | Correct `calculateTotal`, adjust the `verify` target, or change one CI test job. |
| One uniform operation | Apply one small, precisely defined transformation consistently across its required locations. | Rename one symbol, target, job identifier, or configuration key and update its actual references. |

For one-unit mode, relevant tests, fixtures, and verification checks may change to exercise the unit through its smallest available interface. Prefer the existing caller-facing operation when it can reach the unit; otherwise check the function, target, job, or configuration contract directly if practical. Test support does not count as another implementation unit but must remain focused on the requirement; it is not permission to introduce a framework or reorganize the test suite.

Do not add helpers, change another unit's behavior, redesign shared models, or modify callers outside the selected unit. Implement the unit even when other functions, types, targets, jobs, configuration, or wiring must be added later for full behavior to work. Use established dependency contracts and record missing implementations; do not replace them with production stubs, hardcoded success results, or TODO bodies. Count nested functions and methods separately. A selected job may include its own steps and a selected target its own recipe, but neither includes independently owned jobs or targets. Choosing a class, workflow, Makefile, or configuration file does not make all its responsibilities one unit.

For one-operation mode, define the transformation by its semantic target and rule, not by the number of files. For a rename, identify one symbol, target, job, or key, its old name, and its new name. Update its declaration and all actual references, including relevant prerequisites, commands, tests, documentation, or configuration. Use suitable symbol-aware tooling when available and inspect dynamic or string-based references separately. Preserve unrelated names with the same spelling. Do not bundle multiple renames, behavior changes, formatting sweeps, or nearby cleanup into the operation.

"Improve validation everywhere" and "refactor the module" are not uniform operations: they require independent behavior or design decisions. Several small tasks do not become one task because they share a file or goal.

## Workflow

1. **Inspect and bound the task.** Read the relevant contracts, callers, and dependencies, identify the selected unit or transformation, and reuse existing mechanisms. Define its responsibility separately from the full behavior. Identify implementation outside this unit that full behavior will need, then proceed with the selected unit. Keep other implementation changes outside the task.
2. **Prepare the workspace.** Work in the current workspace. If the user requests a dedicated worktree, use the `worktree` skill before source or test edits. Outside Git, use the target directory directly.
3. **Check the starting behavior.** For behavior-preserving operations, run relevant checks before editing. For behavior changes, identify the available checks for the selected contract. If missing implementation outside the unit prevents execution, attempt relevant checks, record the exact blocker, and continue implementing the unit. Keep verification edits focused on the selected unit.
4. **Perform only the selected change.** Apply abstraction levels, narrow interfaces, clear names, and meaningful runtime assertions inside the selected scope. Use existing dependencies. Do not complete another dependency, extract a helper, reorder unrelated functions, split files, or apply Boy Scout cleanup outside the chosen unit merely to satisfy a broader rule.
5. **Review the complete diff.** Check every changed implementation unit and edited location against the scope. In one-unit mode, confirm exactly one function, target, job, or cohesive configuration block was added or changed. In one-operation mode, confirm each edit is required by the same transformation and no independent change was included. Apply the shared diff review and applicable measurements; verify preserved contracts and reference completeness.
6. **Build and verify.** Follow the shared build and interface-check rules as far as the available implementation allows. Fix defects inside the selected unit. Record missing dependencies and wiring that prevent execution or integration checks; preserve the implementation for review rather than abandoning it or adding other units. Distinguish verified unit behavior from full behavior that remains unavailable or unverified.

## Report Remaining Implementation

Needing more than one unit to make the whole behavior work is expected in one-unit mode. Finish the selected unit to the extent supported by known requirements, keep its reviewable changes, and list remaining implementation. Do not stop solely because the full dependency path cannot fit this unit, and do not expand the scope automatically.

For each remaining element, state its location or intended owner, what it must implement, its known input/output and failure contract, and how it connects to the selected unit. Separate missing code, targets or jobs, configuration, concrete dependencies, invocation or artifact wiring, and checks that cannot yet run. Give the necessary implementation order when dependencies determine it, and identify one suitable next increment without executing it.

If a required contract or user-owned decision is genuinely unspecified, ask only for that missing decision and continue independent work that is already defined. Report metric corrections that require another function or operation as remaining work rather than claiming compliance or widening the task.

The selected unit may be implemented while the full behavior is still incomplete. State both statuses explicitly, including any build or runtime failure caused by remaining implementation. Do not claim the full behavior works, hide failures, or claim verification that did not run. One-operation mode still requires completing the chosen transformation consistently; a partial rename is not a completed operation.

## Completion

Provide the shared completion evidence, limited to the selected unit and its available verification surface. Report the mode, native unit or transformation, and changed implementation unit count for one-unit mode, or affected locations and reference checks for one-operation mode. State separately whether the unit's implementation is finished, which checks passed or could not run, and whether full behavior can currently work. Include remaining implementation; say explicitly when none remains.

Stop after implementing this unit, running the checks currently possible, and reporting the remaining elements. Do not automatically implement them or proceed to the next improvement.
