---
name: build-loop
description: Set up the smallest repeatable change, run, observe, and evaluate loop for an engineering goal.
disable-model-invocation: true
---

# Build Loop

Set up an ordered feedback loop before making a sequence of changes. The loop must make the target behavior observable, compare the result with an explicit expectation, and return feedback that selects the next code change. Create the loop in `./loop`.

## When to Use

Use this action when feature work, a bug fix, refactoring, or investigation needs a reliable execution path before changes begin. Apply [Closed Working Loop](../closed-working-loop/SKILL.md) to define the feedback cycle and [Build the Lever](../build-the-lever/SKILL.md) to make that cycle safe and cheap to rerun.

Do not use this action for read-only research or documentation that has no behavior to observe.

## Steps

1. State the smallest observable difference the loop must judge, its expected result, and the condition that disproves the current approach.
2. Select one representative input, state, or scenario. Run it manually before changing code when practical and capture the baseline needed for comparison. Decide whether acceptance requires a human manual review: require one for UI, visual output, interactive flow, or any quality judgment that automation cannot reliably make.
3. Create or update `./loop` and `./loop/README.md`. Keep all stage scripts, generated data, charts, and error output there. Reserve `./loop/cache` for reusable intermediate data that would otherwise slow repeated feedback.
4. Write `./loop/README.md` as the current loop contract. Record the goal and acceptance criterion, the pipeline, every executable stage and its responsibility, and the data each stage needs or produces. Describe source-change targets, inputs or fixtures, required configuration or environment, baseline evidence, cache contents and invalidation, and artifact paths. Update it whenever the stage order or required data changes.
5. When human review is required, add a `Human review` section to the README. State who reviews, how to launch the exact scenario, which states or screens to inspect, what the expected experience is, and what decision records approval, revision, or a blocker. Include the direct execution command or reachable local URL, relevant test account or fixture, and review evidence paths. The reviewer must be able to run and inspect the changed behavior without reconstructing setup from raw logs.
6. Form this repeating pipeline: **code modification → rebuild → run → evaluate → human review when required → feedback → next code modification**. The source edit is made in the target workspace; the ordered scripts rebuild, run, evaluate, prepare human review when required, and publish feedback for that edit. A non-compiling target still needs an equivalent preparation or validation stage in place of a rebuild. The feedback must identify either the next change to try or that the acceptance criterion is met.
7. Choose shell, Python, or TypeScript according to the target command, available runtime, and needed analysis. Create only the ordered executable stage scripts the loop needs. Give rebuild, run, evaluation, and feedback explicit stage responsibilities; add a human-review preparation stage whenever it is required. Add setup, observation, statistics, visualization, cleanup, or comparison stages only when useful. A stage can own more than one adjacent responsibility when separating it would make the loop less clear.
8. Execute the selected stage scripts in explicit numeric order: `01`, then `02`, and so on. The evaluation stage prints one final `PASS`, `FAIL`, or `ERROR` verdict and returns a matching exit status. A behavior mismatch is `FAIL`; an unavailable dependency, invalid setup, or unusable observation is `ERROR`. For a required human review, automated `PASS` means ready for review, not final acceptance. The feedback stage preserves the verdict, points to the evidence, records the human decision when applicable, and states the next code-modification decision.
9. Make the loop safe to rerun. Store reusable intermediate data in `./loop/cache` only when it materially shortens the next run. Reuse a cached result only when its input fingerprint, relevant environment, and producing stage still match; otherwise regenerate it. Add a cache-refresh control only when the work needs one, and choose its interface to fit the relevant stage. The same input must not duplicate data, retain stale output, or change the result.
10. Make the result easy to judge. Always print the expected and actual outcome, the baseline delta when relevant, cache hits or rebuilds when they affect run time, and the path to generated evidence. For repeated or numeric observations, produce summary statistics. Generate a chart or interactive visual only when it makes a trend, distribution, comparison, or relationship easier to judge. On failure, print a concise error summary with the command, exit status, and relevant stack frames, and retain the full raw error output in `./loop/artifacts`.
11. Run every stage in order twice before relying on the loop. Confirm that the evaluation and feedback consistently reach the expected baseline verdict and select an unambiguous next action. When human review is required, perform it against the direct run before declaring the loop accepted; record the decision and repair the setup when it produces an ambiguous result.
12. Expose each stage's required inputs and generated evidence through its normal output or an interface suited to the task. The README and feedback stage expose the ordered sequence, verdict meanings, exit-status contract, data paths, human-review status when applicable, and next-change decision. Do not create an additional Markdown report or a separate loop specification.

## Output

Create the setup in `./loop`:

```text
./loop/README.md                       # purpose, pipeline, stages, and required data
./loop/01-<first-required-stage>.<sh|py|ts>
./loop/02-<next-required-stage>.<sh|py|ts>
...
./loop/NN-<feedback-stage>.<sh|py|ts>
./loop/cache/                         # reusable intermediate data
./loop/artifacts/result.json
./loop/artifacts/summary.json          # when statistics help
./loop/artifacts/chart.svg|png|html    # when a visual helps
./loop/artifacts/human-review.json     # when human review is required
./loop/artifacts/error.log             # when execution fails
```

Choose the number of stage scripts from the work. Every iteration includes rebuild, run, evaluation, and feedback responsibilities; they may be separate stages or combined only when that keeps the flow clearer. UI and other human-judgment work also needs a stage that launches or prepares the direct review. A loop can also need setup, observation, statistics, visualization, cleanup, or comparison stages. Keep numeric prefixes contiguous and make every stage script executable.

Run the executable stages in numeric order:

```sh
./loop/01-<first-required-stage>
./loop/02-<next-required-stage>
...
./loop/NN-<feedback-stage>
```

The README must contain these sections, populated with the actual loop details: `Purpose`, `Acceptance criterion`, `Pipeline`, `Stages`, and `Required data`. Add `Human review` when that review is required for acceptance. In `Pipeline`, show the sequence from code modification through rebuild, run, evaluation, human review when required, feedback, and the next modification. In `Stages`, map each numeric script to its responsibility, inputs, outputs, and failure behavior. In `Required data`, name the relevant source paths, fixtures or inputs, configuration or environment, baseline, cache, and artifacts. In `Human review`, state the direct-run method, review scope, expected outcome, decision format, and evidence path.

When the loop needs arguments, a cache-refresh control, usage output, or another interface detail, choose it for the target work instead of prescribing a universal CLI option. The feedback stage exposes the ordered stage scripts, cache behavior, the `PASS` / `FAIL` / `ERROR` meanings, exit-status contract, evidence paths, human-review status when applicable, and next-change decision through that chosen interface. The ordered stage scripts are the lever: together they rebuild, execute, observe, evaluate, and return feedback. The README explains the loop; the feedback stage makes its outcome immediately decidable without interpreting raw logs.

## Done When

`./loop/README.md` explains the purpose, pipeline, stages, and required data. The ordered stages rebuild, run, evaluate, and return feedback for each code modification; the feedback identifies the next modification or completion. When human review is required, a reviewer directly runs and inspects the scenario and records approval, revision, or a blocker before completion. The evaluation stage returns a clear verdict and exit status, the loop safely reuses valid intermediates or rebuilds them through its chosen interface, a second run with the same input produces the same result, and the feedback surfaces useful statistics, visual, human-review, or error evidence.

## Avoid

- Starting several changes before one target behavior can be observed.
- Calling a broad or slow check when a focused check can judge the goal.
- Treating an environment failure as a result of the change.
- Leaving manual commands outside the ordered stages or requiring the operator to infer the result from logs.
- Building scripts that retain state or duplicate changes on a rerun.
- Reusing cached intermediate data when its inputs, environment, or producing stage have changed.
- Putting loop scripts or generated evidence outside `./loop` without a concrete reason.
- Writing a README that omits the current stages, their data, or the next-change feedback path.
- Stopping at evaluation without publishing feedback that drives the next code modification.
- Treating an automated check, screenshot, or launch success as human approval when the acceptance criterion requires direct review.
