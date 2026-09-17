---
name: understand-through-abstraction
description: Understand code from function contracts downward, reading line by line only when needed.
disable-model-invocation: true
---

# Understand Through Abstraction

For review and root-cause analysis, use functions as units of understanding. Start at the abstract level and descend line by line only into functions that require it.

## Problem It Solves

Reading every line first wastes time on irrelevant detail and loses the responsibility and flow of functions. Judging only from names and input or output misses actual behavior, side effects, and error paths. A function is one level of abstraction: understand its responsibility and contract before reading its implementation.

## How to Apply It

In Madmax Mode, a human must understand the high-level flow to the desired result. Before implementation, briefly explain **start condition or input -> responsibility of main functions -> desired result**. Separate confirmed behavior from the implementation plan and assumptions. Treat internals as a black box when that is sufficient for the flow.

In Chill Mode, code understanding is required before review and change.

1. **Set the question and starting point.** State what you are reviewing or which symptom you are tracing, then begin at its call site or entry function.
2. **Understand the function's abstract contract.** Identify responsibility, inputs, outputs, side effects, error conditions, and callers. Do not read internals when this level answers the question.
3. **Read only unanswered functions line by line.** When actual behavior differs from the contract or you cannot explain cause, impact, or state change, use [Understand Function](../understand-func/SKILL.md) to trace its conditions, state changes, external calls, error handling, and result in order.
4. **Repeat for lower functions when necessary.** Start each important callee with its contract, then descend into its implementation only when needed.
5. **Confirm that you reached the root cause.** Explain the condition and path producing the symptom, its cause, and why the prior contract or validation did not prevent it. Do not treat a symptom-hiding workaround as a cause fix.
6. **Review and improve discovered smells.** Record every smell discovered in Chill Mode with [Record and Resolve Friction](../record-and-resolve-friction/SKILL.md). Review the cause and impact after understanding the code, improve confirmed problems while preserving behavior, and verify with [Closed Working Loop](../closed-working-loop/SKILL.md).

## Stop When

You have enough evidence to answer the current question and choose the next action and verification. In review, you can explain impact and improvement; in root-cause analysis, you can explain causality from code. Complete Chill Mode only after reviewing every discovered smell and verifying needed improvements.

## Avoid

- Assuming actual behavior from a function name or description.
- Reading all related code line by line from the start.
- Following every callee merely because you read its caller.
- Adding a condition or default that hides a symptom and claiming the root cause is fixed.
- Recording discovered smells while skipping review and improvement.
