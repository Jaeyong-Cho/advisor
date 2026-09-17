---
name: bug-report
description: Investigate a reported bug along the relevant execution path and write an evidence-backed root-cause report before fixing it.
disable-model-invocation: true
---

# Bug Report

Preserve a bug-investigation session as a report that lets another engineer verify the symptom, retrace the causal path, and judge the proposed fix.

## When to Use

Use this action when a reported or reproduced bug needs a root-cause investigation record before a fix. Use [Fix Root Causes](../fix-root-causes/SKILL.md) to guide the investigation and [Technical Writing](../technical-writing/SKILL.md) to write the report. The completed report is an input to [TDD Bug Fix](../tdd/SKILL.md): its reproduced scenario, causal boundary, and verification criteria define the smallest useful failing regression test.

Do not use this action for a known, trivial fix that needs no separate investigation record.

## Steps

1. State the reported symptom, affected user or system, expected behavior, actual behavior, environment, input, and known frequency. Preserve the original report separately from later conclusions.
2. Reproduce the symptom when possible. Record the exact reproduction path and the command, request, UI action, log, trace, or test that proves it. If reproduction is blocked, say what was observed and what remains unobserved.
3. Trace the relevant execution path from entry point to symptom. Read each function on that path by contract first, then line by line when needed to explain a state change, branch, value transformation, side effect, or failed invariant. Do not perform a line-by-line read of unrelated code.
4. Record every material observation in traversal order: location and symbol, input or state, line-level behavior, resulting state or output, and the evidence that supports it. Label hypotheses as hypotheses until observation disproves alternatives.
5. State the causal chain from triggering condition to defect. Identify the responsible code, state, contract, validation, or domain rule; explain why existing behavior allowed it; and distinguish the root cause from contributing conditions and visible symptoms.
6. Inspect comparable paths only when they share the proposed cause. Record scope, result, and any follow-up required.
7. Prepare a TDD handoff. Identify the test target, fixture or input, expected assertion, and failing-before signal that express the report's reproduction and root cause without reproducing implementation details. If a focused failing test is impractical, record why and name the closest executable regression check.
8. Recommend the smallest root-cause fix and the verification that would falsify or confirm it. Do not change production code as part of this action unless the caller explicitly includes the fix.
9. Write the report to `bug-reports/{NN}-{slug}.md`. Create `bug-reports/` when it does not exist. Choose the next available numeric prefix without renaming existing reports.

## Report Format

```md
# Bug Report: <short title>

## Reported Symptom

- **Expected:**
- **Actual:**
- **Impact:**
- **Environment and input:**

## Reproduction Evidence

<Exact steps and observed result, or why reproduction is blocked.>

## Investigation Path

1. **<path>:<symbol or line>**
   - **Input or state:**
   - **Observed behavior:**
   - **Evidence:**
   - **Resulting state or output:**

## Causal Analysis

- **Root cause:**
- **Causal chain:**
- **Contributing conditions:**
- **Why existing behavior did not prevent it:**
- **Confidence and remaining uncertainty:**

## Comparable Paths

<Scope inspected and result.>

## TDD Handoff

- **Test target:**
- **Reproduction expressed as a test:**
- **Expected assertion:**
- **Failing-before signal:**
- **Fallback when a focused test is impractical:**

## Recommended Fix and Verification

- **Smallest responsible change:**
- **Verification:**
- **Out of scope:**
```

Use precise paths, symbols, line numbers when they carry evidence, commands, inputs, outputs, and log or test references. Do not copy large source excerpts; link to their locations and explain the decisive behavior.

## Done When

The report makes the symptom, reproduction status, investigated path, causal evidence, root cause or unresolved uncertainty, TDD handoff, fix scope, and verification criteria independently reviewable.

## Avoid

- Presenting an untested hypothesis as the root cause.
- Treating a stack trace or error message as a causal explanation.
- Recording a chronological source dump without state transitions or reasoning.
- Expanding the investigation into unrelated paths without a shared causal condition.
- Describing a symptom-suppressing guard as the recommended fix.
