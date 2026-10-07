---
name: grill-goal
description: Interview the user in rounds to settle a goal and strategic direction. Use for a focused Grill Me discussion about outcomes, priorities, boundaries, and success criteria while leaving implementation details to the AI.
disable-model-invocation: true
---

# Grill Goal

Use the decision-tree interview style of `grill-me` only for the user's goal and direction. Read [Define Goal](../principle-define-goal/SKILL.md) and [Bounded Autonomy](../principle-bounded-autonomy/SKILL.md) first. The user owns the desired outcome and consequential trade-offs; the AI owns methods within those boundaries.

## Decision boundary

Ask about a choice only when its answer changes one of these:

- The problem to solve, who it serves, or why it matters.
- The desired observable outcome and what counts as success.
- The strategic direction, scope, or priority among competing outcomes.
- A hard constraint, preserved behavior, risk tolerance, or delegation boundary.

Choose routine methods yourself: tools, architecture, algorithms, implementation order, and verification mechanics. Bring a method choice to the user only if it changes a user-owned outcome or crosses a stated boundary. Investigate facts available in the environment instead of asking the user to supply them; use subagents for independent fact-finding when useful.

## Rounds

1. **Ground the tree.** Summarize the known current state, desired state, and gap. Separate facts from assumptions. Identify only the unresolved user-owned decisions needed to define the goal and direction.
2. **Ask the frontier.** The frontier contains decisions whose prerequisites are settled. Ask its independent questions together in one round; defer any question that depends on an unanswered one. Number each question and recommend an answer with a short reason. Do not ask questions merely to fill a round.
3. **Update the tree.** Use each answer to settle or reshape downstream decisions. Recompute the frontier and repeat until no consequential goal or direction decision remains. Treat "you decide" as delegation for a method choice; do not silently choose a user-owned outcome or priority.
4. **Confirm shared understanding.** Recap the goal, why it matters, chosen direction, boundaries, success criteria, and which details the AI may decide. Ask the user to confirm or correct the recap. Incorporate corrections and confirm the revised understanding before stopping.

Format each decision question as:

```md
❓ **Q1** - **<decision title>**: <the choice and why it affects the goal or direction>

➡️ <recommended answer and brief reason>
```

## Done When

The user has confirmed a goal and direction that can guide action without further interviews about routine methods. Leave implementation, detailed design, and execution to the AI within the confirmed boundaries; do not start them as part of this discussion skill unless the user separately asks.
