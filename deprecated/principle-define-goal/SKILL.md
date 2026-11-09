---
name: principle-define-goal
description: Define a verifiable goal from the gap between the current and expected state.
disable-model-invocation: true
---

# Define Goal

Define the goal by making the gap between the current state and the expected state explicit.

## Problem It Solves

When a goal is vague, it is hard to decide what to change, whether work moves in the right direction, or when to stop. Expressing an engineering problem as the difference between the current and expected states gives the work direction and a definition of done.

## How to Apply It

1. **Establish the current state.** Inspect the relevant behavior and evidence. Separate confirmed facts from unverified assumptions.
2. **State the expected state.** Express the user's desired result as observable behavior or state. Ask specific questions when information that could change the goal is missing.
3. **Define the gap.** Explain what differs from the expectation and under which conditions the difference appears.
4. **Set completion criteria.** State what result will show that the gap has narrowed or closed.
5. **Choose actions that fit the goal.** Select and perform the actions that reduce the gap. Keep a chosen implementation separate from the goal so that evidence can change the implementation.

## Stop When

You can explain the current state, expected state, gap, and completion criteria, and can choose the next action. Revisit the goal when the expected outcome or constraints change during the work.

## Avoid

- Starting implementation before confirming the expected outcome.
- Treating an assumed current state as a fact.
- Equating completion of a particular implementation with resolution of the user's problem.
- Defining a goal only with statements that cannot be verified.
