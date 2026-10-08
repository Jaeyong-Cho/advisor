---
name: great-code
description: Implement a complete behavior in application code or engineering systems, including Makefiles, build systems, CI workflows, scripts, and configuration. Separate intent, rules, and mechanisms, use interface-focused TDD, and verify required operations, dependencies, and outcomes.
disable-model-invocation: true
---

# Great Code

Implement one coherent behavior in application code or an engineering system, including Makefiles, build systems, CI workflows, scripts, and configuration. Use the abstraction levels the behavior actually needs, represented by native functions, targets, jobs, steps, or configuration rules. Complete required dependencies and wiring within the selected slice rather than leaving TODO stubs or an unfinished interface.

Read [Development Standards](references/development-standards.md) before implementation. That reference owns the shared abstraction, naming, deep-module, assertion, readability, metric, TDD, verification, and completion rules. Reuse it if already loaded in this task.

## Workflow

1. **Define the slice.** Name the user-facing operation and give its one-sentence behavior. If the request combines unrelated flows, identify the smallest coherent flow and keep the rest explicit. Apply the shared abstraction rules to the native entry points, policy decisions, and mechanisms.
2. **Prepare the workspace, then decompose.** Work in the current workspace. If the user requests a dedicated worktree, use the `worktree` skill to prepare it before implementation or test edits. List the decisions and capabilities the flow needs, including direct orchestration of mechanisms where no separate policy exists. Search for existing functions, targets, jobs, configuration, contracts, wiring, and sibling file conventions. Reuse or extend a suitable implementation before creating another; place new definitions beside their peers. Do not manufacture a layer merely to fill the model.
3. **Implement one tested behavior at a time.** Follow the shared TDD cycle through the system's actual interfaces. For each behavior, complete its necessary dependency path using narrow contracts, native mechanisms, and existing composition conventions. Add only the rules, mechanisms, and wiring needed for the current failing check; repeat for the remaining required behaviors. Finish every required function, target, job, configuration rule, and connection in the selected slice.
4. **Review and verify the whole slice.** Apply the shared responsibility, diff-review, metric, build, and interface-test rules across the completed dependency path. Fix failures caused by the change and rerun affected checks before completion. Keep unrelated cleanup and additional use cases outside the slice.

## Completion

Provide the shared completion evidence for the whole slice. Report the entry point, native operations and interfaces, policy and mechanism owners, and whether the complete flow reaches its implementations and produces the required outcomes or artifacts.

If a required business rule or external contract is unspecified, ask only for the missing decision. Do not invent it or claim the slice is complete while necessary implementation or verification remains unresolved.
