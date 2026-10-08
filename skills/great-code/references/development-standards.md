# Development Standards

Read this reference before implementation through either `great-code` or `great-one-code`. It is their single source of shared development rules. Resolve links relative to this directory. If these rules are already loaded in the current task, use them without rereading; do not load the other skill's entrypoint to obtain shared rules.

Apply these standards within the active skill's selected scope. Scope-specific limits and completion rules take precedence over instructions to complete dependencies, extract helpers, split files, reorder definitions, or clean up code. If required work cannot fit that scope, follow the active skill's rules for proceeding and reporting remaining work rather than widening the task silently.

## Application Code and Engineering Systems

These rules cover source code, Makefiles, build definitions, CI workflows, automation scripts, and configuration. Use the system's native operations and contracts rather than inventing functions or classes. Entry points may be public APIs, CLI commands, build targets, or CI triggers; inputs and outputs may be arguments, variables, prerequisites, exit statuses, files, or artifacts.

Separate intent, policy, and mechanisms at the selected scale. A build target or CI job can express intent, prerequisite and execution rules express policy, and recipes, commands, or actions perform mechanisms. Keep related complexity under a cohesive owner with few exposed targets, options, or parameters. Model actual dependencies and artifact flow without pretending declarative definitions form a sequential call chain.

Function exposure, source ordering, and function metrics apply only to actual functions. Do not apply the L1 function-length limit, cyclomatic complexity, or indentation-depth metric to YAML keys, Make recipes, job counts, or configuration blocks. Report such measurements as not applicable, not as measured passes. Preserve required syntax, including Make recipe tabs, quoting, YAML structure, and tool-specific ordering; do not wrap or rearrange declarations in ways that change their meaning.

Use [TDD](tdd.md) for new or changed behavior: one behavior at a time, **RED → GREEN → REFACTOR**, primarily through caller-facing interfaces. Read that reference before changing production behavior. Do not implement the whole change first and add tests afterward.

Apply [Incremental Progress](../../principle-incremental-progress/SKILL.md). Keep the selected increment small and complete, verify its required behavior, and observe the intended improvement before expanding to another change.

Read and actively apply [Assert Invariants](../../principle-assert-invariants/SKILL.md). Identify guaranteed internal preconditions and postconditions, and assert meaningful invariants close to state changes and derived results. Keep expected failures in normal validation and error handling. Assertions supplement interface-focused TDD.

## Work in a Git Worktree

When the target is a Git repository, perform implementation, test edits, refactoring, and verification in a dedicated Git worktree. For a directory outside Git, use the target directory directly.

1. **Inspect the starting state.** Resolve the repository root and inspect its current branch, HEAD, local changes, and existing worktrees. Use a user-specified base when provided; otherwise use the target checkout's current HEAD. Preserve unrelated local changes. If the task depends on uncommitted changes, establish how those changes enter the worktree rather than silently starting from a version that omits them.
2. **Reuse or create the worktree.** Reuse a suitable non-primary worktree already assigned to this task when its base and changes fit the work. Otherwise create a dedicated worktree with the host's worktree manager, or `git worktree add` when no manager is available. Use the repository's branch convention, defaulting to `<feature,bugfix,refactor>/<task-slug>`. Pass the intended base explicitly so a manager's remote-default behavior does not select a different starting point. Do not reset or repurpose another task's checkout.
3. **Use the worktree consistently.** Confirm its absolute path and Git root, read its applicable project instructions, and use that path for every source/test edit, build, and test command. Read-only inspection of the original checkout is allowed. Keep artifacts with the worktree or in the project's designated output location.
4. **Preserve the result for review.** Report the worktree path, branch, base, and verification results. Keep the changes available for review; do not merge them into the original checkout or force-remove the worktree as part of this skill.

If worktree creation or selection fails, resolve that blocker before editing the Git repository. Do not silently fall back to implementation in the original checkout.

## Exposure and File Order

Every entry point (`main`, API handler, or framework entry) and every public or exported function is L1 at the unit being examined. Apply this exposure rule before classifying internal behavior. Exposed functions express the caller's operation; delegate domain rules to internal L2 functions and technical mechanisms to internal L3 functions. Internal orchestration helpers may also be L1. Preserve required public contracts and visibility rather than making a function private merely to obtain a larger length allowance.

Place L1 functions in the first function section of each file, before internal L2/L3 functions. Required imports, module directives, and declarations needed by the language may precede them. Within a class, place L1 methods before internal methods, after required fields or declarations. Put the main or API entry point first among L1 functions when present. Preserve declaration dependencies, registration behavior, and initialization order while arranging definitions; runtime invocation or startup guards remain where the language requires them.

## File Limits and Readability

Every source, script, build-definition, workflow, or configuration file created or modified by this skill must contain **at most 1000 physical lines**. Count the entire file, including imports, declarations, blank lines, and comments. Remove unnecessary definitions and duplication first. If the file still exceeds the limit, split it by coherent responsibilities using supported composition mechanisms and within the active skill's scope. Do not compress statements or create arbitrary fragments and pass-through files just to satisfy the limit.

Use syntax and techniques a junior developer can follow. Prefer named variables, explicit `if`/`else` branches, ordinary loops, and direct function calls. Avoid clever syntax, nested ternaries, dense expression chains, and advanced techniques when straightforward code expresses the same behavior. Preserve required language and framework conventions.

Remove unnecessary duplication in the affected flow. Reuse existing operations and keep repeated domain rules under one meaningful owner. Do not replace similar-looking code with a generic abstraction when it represents different rules or makes callers harder to understand.

## Function Limits

Every function created or modified by this skill must satisfy the applicable limits below:

- **Cyclomatic complexity <= 6.** Measure with a language-compatible analyzer, preferably the project's existing tool, and report the tool used.
- **Function length: L1 <= 50 physical lines. L2 and L3 have no function-length limit.** For L1, count from the first line of the function declaration through the last line of its body, inclusive. Include multiline signatures, blank lines, comments, and closing delimiters; exclude decorators or annotations preceding the declaration.
- **Line width < 100 columns (maximum 99).** Measure every line in the same function span, including indentation, signatures, comments, string literals, and closing delimiters. Expand tabs using the project's configured tab width, or 8 columns if unspecified.
- **Indentation depth <= 3.** Treat the function body's top level as depth 0; each nested code block adds one level. Exclude surrounding class or namespace indentation and continuation alignment for wrapped expressions.

Apply complexity, line-width, and indentation limits to helpers as well as entry points at every level, at the abstraction scale being examined. Apply the function-length limit only to L1 functions. Wrap long lines using the project's formatting style without shortening meaningful names. Use guard clauses or early returns to flatten nesting where they preserve behavior and cleanup. When a function still exceeds an applicable limit, move domain rules or mechanisms to their proper owners, or compose meaningful operations at the appropriate level. Preserve behavior, failure paths, and readable execution order. Do not compress statements, remove useful formatting, introduce pass-through helpers solely to satisfy a metric, or relabel orchestration as L2/L3 merely to meet the limits.

## Responsibilities and Diff Review

L1 expresses the caller's workflow without inline infrastructure or reimplemented business rules. L2 owns policy, validation, calculations, and state transitions without inline infrastructure. L3 performs mechanisms without making business decisions. Same-level composition and a justified L1 → L3 call are valid; lower levels never call upward. Use [Abstraction Levels](abstraction-levels.md) for classification and smells, [Naming](naming.md) for intention-revealing names, and [Deep Modules](deep-modules.md) to keep interfaces narrow and hide technical complexity. Keep `L1`/`L2`/`L3` and skill names out of code comments and docstrings.

Read the finished functions and relevant call sites for leaking mechanisms, missing or hidden domain rules, shallow orchestration, and mechanical extraction. Check exposure and file order within the selected scope. Measure the full physical line count of every created or modified source file. Measure complexity, maximum line width, and maximum indentation depth for every created or modified function; measure function length only for L1 functions. Correct violations within the active skill's scope and remeasure. If a correction requires broader work, follow that skill's scope rules. Report unavailable measurements as unverified rather than estimating a pass or claiming completion.

Check that syntax is understandable to a junior developer and unnecessary duplication is removed within scope. Implement the selected unit without TODO bodies or temporary production stubs. Apply the active skill's completion rules to dependency implementations, callers, and interface wiring; explicitly report any implementation it permits deferring.

## Build and Basic Tests

For system changes, verify through the actual command, target, workflow, or configuration interface. Choose checks that demonstrate the requested behavior: relevant outputs or artifacts, exit statuses, dependency selection, preserved failure handling, and incremental or cache behavior when required. Use a meaningful failing acceptance check before changing behavior, then rerun it after the minimum implementation. A text match, parse result, or schema check alone does not establish that the operation works.

Use existing validators and local execution paths where applicable. A dry run or execution plan can verify planned commands and dependencies, but cannot prove that commands succeed or artifacts are correct. When actual CI or remote execution is needed but unavailable, state the remaining verification gap and what must run; do not present local validation as a successful remote run. Keep verification proportional to the selected behavior.

Apply invariant checks through native mechanisms where meaningful, such as artifact consistency checks or explicit postconditions on a completed operation. Keep expected missing input, unavailable tools, network errors, and other legitimate failures in normal error handling rather than treating them as implementation invariants.

For a behavior-preserving rename or refactor, run relevant existing checks before and after. Add a focused characterization test only when needed to establish the preserved contract. Do not manufacture a failing behavior test or claim a RED/GREEN cycle when no behavior changes. Apply the TDD steps below when behavior is added or changed; apply the interface, assertion, build, and final-check rules to both cases.

Apply [Closed Working Loop](../../principle-closed-working-loop/SKILL.md) throughout TDD and final verification.

- **Discover the project's commands.** Read the relevant project instructions, scripts, manifests, and CI configuration to identify the build and test commands for the affected application or package. Use its existing toolchain and runner.
- **RED: prove the missing behavior.** Before changing production behavior, add or strengthen one test through the smallest interface that exposes the requirement, then run it. Confirm it fails because the required behavior is absent or incorrect. An unrelated dependency, environment, or syntax failure is not RED evidence. If the test already passes, check whether the behavior already exists and avoid unnecessary implementation.
- **GREEN: implement the minimum.** Make the smallest production change that satisfies the current test and preserves existing contracts. Run the test and affected existing tests until they pass. Do not weaken assertions to fit incorrect behavior or implement speculative future behaviors.
- **Exercise runtime assertions.** While implementing each behavior, inspect its internal contracts and add useful invariant checks proactively. Run relevant interface tests with the project's assertions enabled. During review, check omitted invariant checks, predicate purity, expected-failure handling, and assertion enablement. Do not add assertions solely to satisfy a quota or remove meaningful checks to meet a metric.
- **REFACTOR: simplify while green.** Once the tests pass, improve responsibility boundaries, remove duplication, and narrow interfaces within the selected scope. Rerun affected tests after each refactor. Repeat RED → GREEN → REFACTOR for the next required behavior; do not write all tests first and all implementation afterward.
- **Run the build.** Execute the relevant build after implementation. If the project has no build step, run its type check, compilation, or syntax check when applicable and state which check substitutes for the build. If none applies, report that explicitly.
- **Test primarily through interfaces.** Exercise concrete behavior through module operations, public APIs, commands, build targets, workflow entry points, or infrastructure contracts. Assert outputs, observable state changes, required side effects, artifacts, exit statuses, and failure outcomes. Cover internal logic through these interfaces by default. Do not create a test suite for every helper, expose private functions solely for testing, or assert internal call order and intermediate state. Prefer real internal collaborators; mock only a genuine external boundary when isolation is needed. Checks should survive internal changes that preserve the contract. Interface-focused testing does not require a full-system E2E test for every change.
- **Run final tests.** After the TDD cycles, run tests covering the changed behavior and its immediate dependencies. Use the standard test suite when it is lightweight or required by the project. Verify the main successful path and a meaningful rejection or failure path when applicable. If no relevant test setup exists, use a small runnable assertion-based check for RED and GREEN. A smoke check after implementation alone does not satisfy TDD.
- **Keep verification proportional.** Prefer existing tests and direct execution. Add a small behavior-based test only when needed to verify meaningful changed behavior with the existing test setup; do not introduce a testing framework or broad coverage work merely to satisfy this step. Add a focused internal rule test only when it provides meaningful confidence that interface tests cannot provide practically, and explain the gap it covers. Use [Testing by level](abstraction-levels.md#testing-by-level) to choose the smallest sufficient interface and test scope.
- **Resolve failures and state limits.** Fix failures caused by the change, then rerun the affected build and tests. Identify unrelated existing failures or missing dependencies, credentials, or services with evidence. Report a blocked or skipped check as unverified; do not claim completion while required verification remains unresolved. A passing build or mock does not establish real integration behavior.

For new or changed behavior, if no meaningful failing test or executable assertion can run, report the concrete blocker and resolve the necessary test setup before implementing the affected behavior. Do not silently switch to implementation-first development or claim a verified TDD cycle without RED and GREEN evidence.

## Completion Evidence

Report the achieved result and the affected functions, targets, jobs, configuration blocks, interfaces, and file locations at the selected scope. For Git work, include the absolute worktree path, branch, starting commit, and any task-relevant uncommitted changes carried into it. Outside Git, include the target directory.

Report the physical line count of each created or modified implementation or configuration file. For each actual function created or modified, report its abstraction level, cyclomatic complexity and analyzer, maximum line width, and maximum indentation depth; report function length for L1 functions only. For declarative units, report their responsibility, inputs, dependencies, outputs or artifacts, and relevant validation results; mark function-specific metrics as not applicable. State what was reused versus implemented and the outcome of applicable structure, readability, duplication, and metric checks. Identify scope-constrained corrections and verification limits explicitly.

Include exact build and test or smoke-check commands, their results, affected interface behaviors, and remaining dependency or coverage gaps. For behavior changes, include the intended failure observed before implementation and the passing result afterward. Distinguish demonstrated RED/GREEN cycles from final checks. For behavior-preserving operations, report the before/after checks without claiming a TDD cycle.

Report consequential invariants asserted and whether runtime assertions were enabled during verification. State intentionally diagnostic-only checks and assertions whose execution remains unverified. Report blocked or skipped required checks as unverified; do not claim a complete, verified result while necessary scope or verification remains unresolved.
