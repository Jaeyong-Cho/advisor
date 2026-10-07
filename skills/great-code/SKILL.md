---
name: great-code
description: Implement a complete use case across intent (L1), domain behavior (L2), and technical mechanisms (L3) using interface-focused TDD, then run the project's build and relevant tests. Reuse existing code and finish required functions and interfaces without leaving implementation stubs.
disable-model-invocation: true
---

# Great Code

Implement one coherent use case as working code across the abstraction levels it actually needs. Complete the required dependencies and wiring within that use-case slice, rather than leaving TODO stubs or an unfinished interface.

Read [Development Standards](references/development-standards.md) before implementation. That reference owns the shared worktree, abstraction, naming, deep-module, assertion, readability, metric, TDD, verification, and completion rules. Reuse it if already loaded in this task.

## Workflow

1. **Define the slice.** Name the L1 use case and give its one-sentence behavior. If the request combines unrelated flows, identify the smallest coherent flow and keep the rest explicit. Classify entry points and public/exported functions as L1 first, then apply the shared abstraction rules to internal orchestration, business rules, and mechanisms.
2. **Prepare the workspace, then decompose.** Follow the shared worktree rules before source or test edits. List the L2 decisions and L3 capabilities the flow needs, including direct L1 → L3 calls where no business rule exists. Search for existing functions, contracts, implementations, wiring, and sibling file conventions. Reuse or extend a suitable implementation before creating another; place new code beside its peers. Do not manufacture an L2 rule just to fill a layer.
3. **Implement one tested behavior at a time.** Follow the shared TDD cycle. For each behavior, complete its necessary dependency path: reuse or define narrow L3 contracts, implement concrete mechanisms behind them, keep L2 rules independent of concrete clients, and connect the L1 operation through the project's existing composition convention. Add only the rules, mechanisms, and wiring needed for the current failing test; repeat for the remaining required behaviors. Finish every required function and connection in the selected use case.
4. **Review and verify the whole slice.** Apply the shared responsibility, diff-review, metric, build, and interface-test rules across the completed dependency path. Fix failures caused by the change and rerun affected checks before completion. Keep unrelated cleanup and additional use cases outside the slice.

## Completion

Provide the shared completion evidence for the whole slice. Report the L1 entry point, the L2/L3 functions and interfaces it uses, and whether the complete flow reaches its concrete implementations.

If a required business rule or external contract is unspecified, ask only for the missing decision. Do not invent it or claim the slice is complete while necessary implementation or verification remains unresolved.
