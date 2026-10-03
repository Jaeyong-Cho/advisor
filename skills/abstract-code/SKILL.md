---
name: abstract-code
description: Implement a complete use case across intent (L1), domain behavior (L2), and technical mechanisms (L3) from a plain-language request, then run the project's build and basic tests. Reuse existing code and finish required functions and interfaces without leaving implementation stubs.
disable-model-invocation: true
---

# Abstract Code

Implement one coherent use case as working code across the abstraction levels it actually needs. This combines the implementation work of `l1-implement`, `l2-implement`, and `l3-implement` in one pass: missing dependencies are completed here rather than left as TODO stubs or handed to another skill.

## Exposure and File Order

Every entry point (`main`, API handler, or framework entry) and every public or exported function is L1 at the unit being examined. Apply this exposure rule before classifying internal behavior. Exposed functions express the caller's operation; delegate domain rules to internal L2 functions and technical mechanisms to internal L3 functions. Internal orchestration helpers may also be L1. Preserve required public contracts and visibility rather than making a function private merely to obtain a larger length allowance.

Place L1 functions in the first function section of each file, before internal L2/L3 functions. Required imports, module directives, and declarations needed by the language may precede them. Within a class, place L1 methods before internal methods, after required fields or declarations. Put the main or API entry point first among L1 functions when present. Preserve declaration dependencies, registration behavior, and initialization order while arranging definitions; runtime invocation or startup guards remain where the language requires them.

## File Limits and Readability

Every source file created or modified by this skill must contain **at most 300 physical lines**. Count the entire file, including imports, declarations, blank lines, and comments. Remove unnecessary code and duplication first. If the file still exceeds the limit, split it by coherent responsibilities beside its existing peers. Do not compress statements or create arbitrary fragments and pass-through files just to satisfy the limit.

Use syntax and techniques a junior developer can follow. Prefer named variables, explicit `if`/`else` branches, ordinary loops, and direct function calls. Avoid clever syntax, nested ternaries, dense expression chains, and advanced techniques when straightforward code expresses the same behavior. Preserve required language and framework conventions.

Remove unnecessary duplication in the affected flow. Reuse existing operations and keep repeated domain rules under one meaningful owner. Do not replace similar-looking code with a generic abstraction when it represents different rules or makes callers harder to understand.

## Function Limits

Every function created or modified by this skill must satisfy all four limits:

- **Cyclomatic complexity <= 6.** Measure with a language-compatible analyzer, preferably the project's existing tool, and report the tool used.
- **Function length: L1 <= 50 physical lines; L2 and L3 <= 100 physical lines.** Count from the first line of the function declaration through the last line of its body, inclusive. Include multiline signatures, blank lines, comments, and closing delimiters; exclude decorators or annotations preceding the declaration.
- **Line width < 100 columns (maximum 99).** Measure every line in the same function span, including indentation, signatures, comments, string literals, and closing delimiters. Expand tabs using the project's configured tab width, or 8 columns if unspecified.
- **Indentation depth <= 3.** Treat the function body's top level as depth 0; each nested code block adds one level. Exclude surrounding class or namespace indentation and continuation alignment for wrapped expressions.

Apply the limits to helpers as well as entry points at every level, at the abstraction scale being examined. Wrap long lines using the project's formatting style without shortening meaningful names. Use guard clauses or early returns to flatten nesting where they preserve behavior and cleanup. When a function still exceeds any limit, move domain rules or mechanisms to their proper owners, or compose meaningful operations at the appropriate level. Preserve behavior, failure paths, and readable execution order. Do not compress statements, remove useful formatting, introduce pass-through helpers solely to satisfy a metric, or relabel orchestration as L2/L3 merely to meet the limits.

## Workflow

1. **Define the slice.** Name the L1 use case and give its one-sentence behavior. If the request combines unrelated flows, identify the smallest coherent flow and keep the rest explicit. Identify entry points and public/exported functions as L1 first, then apply the one-sentence and three-level tests in [Abstraction Levels](references/abstraction-levels.md) to distinguish internal orchestration, business rules, and mechanisms.
2. **Decompose and search before editing.** List the L2 decisions and L3 capabilities the flow needs, including any direct L1 → L3 call where no business rule exists. Search for existing functions, contracts, implementations, wiring, and sibling file conventions. Reuse or extend a suitable implementation before creating another; place new code beside its peers. Do not manufacture an L2 rule just to fill a layer.
3. **Implement the complete dependency path.** Define or reuse narrow, capability-oriented L3 interfaces. Implement any missing concrete L3 mechanisms behind those interfaces; keep database, HTTP, SDK, filesystem, serialization, and technical retry details there. Implement the L2 rules in domain terms, depending on L3 interfaces rather than concrete clients. Implement the L1 function last as a readable sequence of named operations, then connect the concrete mechanism through the project's existing composition or dependency-injection convention. Final source order places L1 functions first regardless of implementation order. Finish every required function and connection in this pass; do not leave loud stubs, TODO bodies, or an unwired interface.
4. **Keep responsibilities clear.** L1 expresses the caller's workflow without inline infrastructure or reimplemented business rules. L2 owns policy, validation, calculations, and state transitions without inline infrastructure. L3 performs mechanisms without making business decisions. Same-level composition and a justified L1 → L3 call are valid; lower levels never call upward. Use [Naming](references/naming.md) for intention-revealing names and [Deep Modules](references/deep-modules.md) to keep interfaces narrow and hide technical complexity. Apply the file-limit, readable-syntax, and duplication rules above. Keep `L1`/`L2`/`L3` and skill names out of code comments and docstrings.
5. **Review the actual diff.** Read the finished functions and their call sites against the smells in [Abstraction Levels](references/abstraction-levels.md): leaking mechanisms, missing or hidden domain rules, shallow orchestration, and mechanical extraction. Check that entry points and public/exported functions are L1 and appear before internal functions. Measure the full physical line count of every created or modified source file against the 300-line limit. Measure complexity, physical line count, maximum line width, and maximum indentation depth for every created or modified function, using its level's length limit. Refactor any violation and remeasure the affected files and functions before completion. Check that the syntax is understandable to a junior developer and unnecessary duplication is removed. Fix each issue found and verify the interface has a concrete implementation and the use case reaches it. If a metric cannot be measured, report it as unverified rather than estimating a pass or claiming completion.
6. **Build and run basic tests.** After implementation and review, follow the verification guidance below. Fix failures caused by the change and rerun the affected checks before completion.

## Build and Basic Tests

Apply [Closed Working Loop](../principle-closed-working-loop/SKILL.md): implementation is followed by execution, observation, and correction.

- **Discover the project's commands.** Read the relevant project instructions, scripts, manifests, and CI configuration to identify the build and test commands for the affected application or package. Use its existing toolchain and runner.
- **Run the build.** Execute the relevant build after implementation. If the project has no build step, run its type check, compilation, or syntax check when applicable and state which check substitutes for the build. If none applies, report that explicitly.
- **Run basic tests.** Run existing tests covering the changed behavior and its immediate dependencies. Use the standard test suite when it is lightweight or required by the project. Verify the main successful path and a meaningful rejection or failure path when applicable. If no relevant tests exist, perform a minimal smoke check through the affected entry point with representative input and inspect the observable result.
- **Keep verification proportional.** Prefer existing tests and direct execution. Add a small behavior-based test only when needed to verify meaningful changed behavior with the existing test setup; do not introduce a testing framework or broad coverage work merely to satisfy this step. Use [Testing by level](references/abstraction-levels.md#testing-by-level) to choose the lowest sufficient check.
- **Resolve failures and state limits.** Fix failures caused by the change, then rerun the affected build and tests. Identify unrelated existing failures or missing dependencies, credentials, or services with evidence. Report a blocked or skipped check as unverified; do not claim completion while required verification remains unresolved. A passing build or mock does not establish real integration behavior.

## Completion

Report the L1 entry point and the L2/L3 functions and interface it uses, with file locations. Report the measured physical line count of each created or modified source file. For each created or modified function, report its level, measured cyclomatic complexity, physical line count, maximum line width, and maximum indentation depth. State what was reused versus implemented, the result of the exposure, file-order, layer-mixing, readability, duplication, and metric checks, and any remaining external dependency or coverage gap. Include the exact build and test or smoke-check commands, their results, and any verification limits. If a required business rule or external contract is unspecified, ask only for the missing decision; do not invent it or claim the slice is complete.
