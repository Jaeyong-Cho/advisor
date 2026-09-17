---
name: to-goal
description: Turn a request and observed current state into a concrete, verifiable goal before implementation.
disable-model-invocation: true
---

# To Goal

Produce a short goal record that separates the desired outcome from a chosen implementation.

## When to Use

Use this action when a request is ambiguous, the current state is uncertain, completion is unclear, or implementation is about to begin. Apply [Define Goal](../define-goal/SKILL.md) to judge the result.

## Steps

1. Inspect the relevant current behavior and collect evidence.
2. State the expected observable behavior or state.
3. Describe the gap between the current and expected states, including the conditions where it appears.
4. List constraints, preserved behavior, and assumptions. Mark assumptions that could change the goal.
5. Define completion criteria and the smallest check that will verify them.
6. Select the next action without treating an implementation choice as the goal.

## Output

Write the goal record to `GOAL.md` with these fields:

```md
# Goal: <outcome>

## Current State

## Expected State

## Gap

## Constraints and Assumptions

## Completion Criteria

## Next Action
```

## Done When

The current state, expected state, gap, constraints, completion criteria, and next action are explicit. A reader can tell whether the goal is complete without knowing the proposed implementation.
