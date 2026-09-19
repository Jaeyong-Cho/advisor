---
name: experiment
description: Run a lightweight plan, act, and analysis experiment to answer a question with recorded evidence. Invoke as /experiment.
disable-model-invocation: true
---

# Experiment

Turn a question that cannot be resolved by inspection into the smallest real experiment that produces a trustworthy verdict.

## Steps

1. **Plan.** Select the cheapest method that can resolve the question and state the expected result that would support or refute it. For a question about whether a state model, logic, or appearance works, consider the throwaway-prototype guidance in [Prototype](references/prototype.md). Confirm the plan with the user before acting, using [Question format](references/question-format.md).
2. **Act.** Execute the method for real. A script, query, test, or prototype must produce captured output. Do not edit production files. Keep every file that ran the experiment under the report's `.raw/` directory, along with `regenerate.sh` or an equivalent single command that reruns the whole experiment.
3. **Analyze.** Compare the real result with the stated expectation. State whether the hypothesis is supported, refuted, or inconclusive.
4. **Write the report.** Write one Markdown report using the structure below. Keep raw logs and detailed data in an Appendix when they would obscure Results.
5. **Choose the location.** Update an existing report for the same question. Otherwise, confirm the output directory with the user, recommending `./experiments/`. Read [Research topic directory](references/research-topic-directory.md) only when the user asks to file it in the research wiki. Use the next available zero-padded number for a new report.
6. **Lint the report.** Run `python3 scripts/lint_report.py <report.md>` from this skill directory. Fix every reported violation and rerun it until it reports `OK`.

## Report Format

```markdown
# {Title}

## Abstract
{One paragraph containing the question and verdict.}

## 1. Introduction
{The question and why it required an experiment.}

## 2. Background
{Context needed to follow the method.}

## 3. Methodology
{The planned method and pass/fail expectation.}

## 4. Results
{Verdict-relevant output, with exact paths to `regenerate.sh` and `.raw/` files.}

## 5. Discussion
{Meaning, comparison with the expectation, and limitations.}

## 6. Conclusion
{The verdict: supported, refuted, or inconclusive.}
```

## Done When

The report presents a verdict supported by reproducible, recorded output. Its raw inputs and rerun command remain beside the report, and the report linter passes.
