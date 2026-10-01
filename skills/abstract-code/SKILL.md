---
name: abstract-code
description: Implement a complete use case across intent (L1), domain behavior (L2), and technical mechanisms (L3) from a plain-language request. Reuse existing code and finish required functions and interfaces without leaving implementation stubs.
---

# Abstract Code

Implement one coherent use case as working code across the abstraction levels it actually needs. This combines the implementation work of `l1-implement`, `l2-implement`, and `l3-implement` in one pass: missing dependencies are completed here rather than left as TODO stubs or handed to another skill.

## L1 Function Limits

Every L1 function created or modified by this skill must satisfy all three limits:

- **Cyclomatic complexity <= 6.** Measure with a language-compatible analyzer, preferably the project's existing tool, and report the tool used.
- **Function length <= 50 physical lines.** Count from the first line of the function declaration through the last line of its body, inclusive. Include multiline signatures, blank lines, comments, and closing delimiters; exclude decorators or annotations preceding the declaration.
- **Line width < 100 columns (maximum 99).** Measure every line in the same function span, including indentation, signatures, comments, string literals, and closing delimiters. Expand tabs using the project's configured tab width, or 8 columns if unspecified.

Apply the limits to L1 helpers as well as entry points, at the abstraction scale being examined. Wrap long lines using the project's formatting style without shortening meaningful names. When a function still exceeds any limit, move domain rules or mechanisms to their proper owners, or compose meaningful L1 operations. Preserve behavior, failure paths, and readable execution order. Do not compress statements, remove useful formatting, introduce pass-through helpers, or relabel orchestration as L2/L3 merely to meet the limits.

## Workflow

1. **Define the slice.** Name the L1 use case and give its one-sentence behavior. If the request combines unrelated flows, identify the smallest coherent flow and keep the rest explicit. Apply the one-sentence and three-level tests in [Abstraction Levels](references/abstraction-levels.md) to distinguish orchestration, business rules, and mechanisms.
2. **Decompose and search before editing.** List the L2 decisions and L3 capabilities the flow needs, including any direct L1 → L3 call where no business rule exists. Search for existing functions, contracts, implementations, wiring, and sibling file conventions. Reuse or extend a suitable implementation before creating another; place new code beside its peers. Do not manufacture an L2 rule just to fill a layer.
3. **Implement the complete dependency path.** Define or reuse narrow, capability-oriented L3 interfaces. Implement any missing concrete L3 mechanisms behind those interfaces; keep database, HTTP, SDK, filesystem, serialization, and technical retry details there. Implement the L2 rules in domain terms, depending on L3 interfaces rather than concrete clients. Implement the L1 function last as a readable sequence of named operations, then connect the concrete mechanism through the project's existing composition or dependency-injection convention. Finish every required function and connection in this pass; do not leave loud stubs, TODO bodies, or an unwired interface.
4. **Keep responsibilities clear.** L1 expresses the caller's workflow without inline infrastructure or reimplemented business rules. L2 owns policy, validation, calculations, and state transitions without inline infrastructure. L3 performs mechanisms without making business decisions. Same-level composition and a justified L1 → L3 call are valid; lower levels never call upward. Use [Naming](references/naming.md) for intention-revealing names and [Deep Modules](references/deep-modules.md) to keep interfaces narrow and hide technical complexity. Keep `L1`/`L2`/`L3` and skill names out of code comments and docstrings.
5. **Review the actual diff.** Read the finished functions and their call sites against the smells in [Abstraction Levels](references/abstraction-levels.md): leaking mechanisms, missing or hidden domain rules, shallow orchestration, and mechanical extraction. Measure complexity, physical line count, and maximum line width for every created or modified L1 function. Refactor any violation and remeasure all three metrics before completion. Fix each issue found, verify the interface has a concrete implementation and the use case reaches it, and run the project's relevant build or type check when available. If a metric cannot be measured, report it as unverified rather than estimating a pass or claiming completion.

This skill writes implementation code only; it does not add tests. For coverage or regression work, follow the behavior-based guidance in [TDD](references/tdd.md) and [Abstraction Levels](references/abstraction-levels.md) as a separate step. Do not claim integration behavior was verified by a build or mock.

## Completion

Report the L1 entry point and the L2/L3 functions and interface it uses, with file locations. For each created or modified L1 function, report its measured cyclomatic complexity, physical line count, and maximum line width. State what was reused versus implemented, the result of the layer-mixing review and checks, and any remaining external dependency or coverage gap. If a required business rule or external contract is unspecified, ask only for the missing decision; do not invent it or claim the slice is complete.
