---
name: build-loop
description: Set up the smallest repeatable change, run, observe, and evaluate loop for an engineering goal.
disable-model-invocation: true
---

# Build Loop

Set up an ordered feedback loop before making a sequence of changes. The loop must make the target behavior observable, compare the result with an explicit expectation, and return an evaluation that makes the next change obvious. Create its scripts in `./loop`.

## When to Use

Use this action when feature work, a bug fix, refactoring, or investigation needs a reliable execution path before changes begin. Apply [Closed Working Loop](../closed-working-loop/SKILL.md) to define the feedback cycle and [Build the Lever](../build-the-lever/SKILL.md) to make that cycle safe and cheap to rerun.

Do not use this action for read-only research or documentation that has no behavior to observe.

## Steps

1. State the smallest observable difference the loop must judge, its expected result, and the condition that disproves the current approach.
2. Select one representative input, state, or scenario. Run it manually before changing code when practical and capture the baseline needed for comparison.
3. Create or update `./loop`. Keep all setup scripts, generated data, charts, and error output there. Reserve `./loop/cache` for reusable intermediate data that would otherwise slow repeated feedback.
4. Choose shell, Python, or TypeScript according to the target command, available runtime, and needed analysis. Create only the ordered executable stage scripts the loop needs. Each script owns one responsibility, such as preparing stable inputs, exercising behavior, collecting an observation, computing statistics, rendering a visual, or cleaning up.
5. Execute the selected stage scripts in explicit numeric order: `01`, then `02`, and so on. The final stage evaluates the collected evidence, prints one final `PASS`, `FAIL`, or `ERROR` verdict, and returns a matching exit status. A behavior mismatch is `FAIL`; an unavailable dependency, invalid setup, or unusable observation is `ERROR`.
6. Make the loop safe to rerun. Store reusable intermediate data in `./loop/cache` only when it materially shortens the next run. Reuse a cached result only when its input fingerprint, relevant environment, and producing stage still match; otherwise regenerate it. Add a cache-refresh control only when the work needs one, and choose its interface to fit the relevant stage. The same input must not duplicate data, retain stale output, or change the result.
7. Make the result easy to judge. Always print the expected and actual outcome, the baseline delta when relevant, cache hits or rebuilds when they affect run time, and the path to generated evidence. For repeated or numeric observations, produce summary statistics. Generate a chart or interactive visual only when it makes a trend, distribution, comparison, or relationship easier to judge. On failure, print a concise error summary with the command, exit status, and relevant stack frames, and retain the full raw error output in `./loop/artifacts`.
8. Run every stage in order twice before relying on the loop. Confirm that the final stage reaches the expected baseline verdict consistently and that its verdict can accept or reject the current hypothesis. Repair the setup when it produces an ambiguous result.
9. Expose each stage's required inputs and generated evidence through its normal output or an interface suited to the task. The final stage exposes the ordered sequence, verdict meanings, exit-status contract, and evidence paths. Do not create a Markdown report or a separate loop specification.

## Output

Create the setup in `./loop`:

```text
./loop/01-<first-required-stage>.<sh|py|ts>
./loop/02-<next-required-stage>.<sh|py|ts>
...
./loop/NN-<final-evaluate-stage>.<sh|py|ts>
./loop/cache/                         # reusable intermediate data
./loop/artifacts/result.json
./loop/artifacts/summary.json          # when statistics help
./loop/artifacts/chart.svg|png|html    # when a visual helps
./loop/artifacts/error.log             # when execution fails
```

Choose the number of stage scripts from the work. A loop can need only an exercise and evaluation stage, or it can need extra setup, observation, statistics, visualization, cleanup, or comparison stages. Keep numeric prefixes contiguous and make every stage script executable.

Run the executable stages in numeric order:

```sh
./loop/01-<first-required-stage>
./loop/02-<next-required-stage>
...
./loop/NN-<final-evaluate-stage>
```

When the loop needs arguments, a cache-refresh control, usage output, or another interface detail, choose it for the target work instead of prescribing a universal CLI option. The final stage exposes the ordered stage scripts, cache behavior, the `PASS` / `FAIL` / `ERROR` meanings, exit-status contract, and evidence paths through that chosen interface. The ordered stage scripts are the lever: together they perform setup, execution, observation, and evaluation. Do not require the operator to read a Markdown file or interpret raw logs to decide the verdict.

## Done When

The ordered stages run in sequence, the final stage returns a clear verdict and exit status, the loop safely reuses valid intermediates or rebuilds them through its chosen interface, a second run with the same input produces the same result, and the final stage surfaces useful statistics, visual, or error evidence.

## Avoid

- Starting several changes before one target behavior can be observed.
- Calling a broad or slow check when a focused check can judge the goal.
- Treating an environment failure as a result of the change.
- Leaving manual commands outside the ordered stages or requiring the operator to infer the result from logs.
- Building scripts that retain state or duplicate changes on a rerun.
- Reusing cached intermediate data when its inputs, environment, or producing stage have changed.
- Putting loop scripts or generated evidence outside `./loop` without a concrete reason.
- Recording ordered stages without their inputs, observation, final verdict contract, or evidence paths.
