---
name: principle-closed-working-loop
description: Use a minimal change, run, observe, evaluate loop to guide engineering work.
disable-model-invocation: true
---

# Closed Working Loop

Create a precise, minimal loop that fits the goal: **change -> run -> observe -> evaluate -> change again**.

## Problem It Solves

Without a way to run and observe a change, it is difficult to know whether it helps reach the goal. Feedback that is too slow or unrelated to the goal lets incorrect changes accumulate. Feature work, bug fixes, and refactoring need an environment that reveals results and informs the next action.

## How to Apply It

1. **Name the difference to verify.** State what must change from the current state. Apply [Define Goal](../principle-define-goal/SKILL.md) first when the goal is unclear.
2. **Create an execution path.** Prepare the environment, input, command, or interaction needed to run the relevant behavior repeatedly. Observe the behavior before the change when practical.
3. **Choose the smallest valid check.** Select the build, test, direct run, or log observation that can judge completion. A fast check that is unrelated to the goal is insufficient.
4. **Change and run.** Make a change small enough to evaluate, then observe the result under the same conditions.
5. **Evaluate and choose the next action.** Compare the expected and actual results. Finish, revise the change, or revise the hypothesis and check.

Break refactoring into small changes whose behavior can be checked after each step. If the same change or check repeats, apply [Build the Lever](../principle-build-the-lever/SKILL.md) and include a rerunnable tool in the loop.

## Stop When

You can check the goal's completion criteria and the result meets them. Do not treat a failed run or an environment failure as completed verification.

## Avoid

- Accumulating changes without a way to run or observe their result.
- Checking only an easy result that does not relate to the goal.
- Running under different conditions each time so that effects cannot be compared.
- Repeating the same change without using observations to guide the next decision.
