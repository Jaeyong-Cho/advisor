---
name: to-goal
description: Record a confirmed goal, its reason, boundaries, and verification criteria in GOAL.md before implementation.
disable-model-invocation: true
---

# To Goal

Produce a short goal record that states what outcome the user wants and why it matters, separate from a chosen implementation. Use the current working directory as the default workspace root, unless the user specifies another root. Write the goal at `<workspace-root>/GOAL.md`.

## When to Use

In an Advisor execution flow, use this action after Grill Me establishes the user-confirmed goal and reason, and before implementation. For other flows, use it when a consequential ambiguity needs a durable goal record or a multi-session effort needs continuity. Apply [Define Goal](../principle-define-goal/SKILL.md) to judge the result.

## Steps

1. Inspect the relevant current behavior and collect evidence.
2. State the expected observable behavior or state and why achieving it matters to the user.
3. Describe the gap between the current and expected states, including the conditions where it appears.
4. List constraints, preserved behavior, and assumptions. Mark assumptions that could change the goal.
5. Define completion criteria and the smallest check that will verify them.
6. Select the next action without treating an implementation choice as the goal.

## Output

Write the goal record to `<workspace-root>/GOAL.md` with these fields.

```md
# Goal: <outcome>

## Why

## Current State

## Expected State

## Gap

## Constraints and Assumptions

## Completion Criteria

## Next Action
```

## Done When

The confirmed outcome, reason, current state, expected state, gap, constraints, completion criteria, and next action are explicit. A reader can tell whether the goal is complete without knowing the proposed implementation.
