---
name: first-principle-redesign
description: Redesign from Why, What, and How instead of preserving the current implementation by default.
disable-model-invocation: true
---

# First Principle Redesign

When reviewing code and design or changing structure in Chill Mode, reason and explain in **Why - What - How** order. Treat the current implementation as a candidate, not a fixed premise.

## Problem It Solves

A method selected to reach a goal quickly in Madmax Mode can become an assumed design requirement. Fixing How first encourages reinterpretation of Why to preserve the method and makes a better structure harder to choose.

Derive the design again from purpose and requirements. Ask: **If the current implementation did not exist, would we choose this structure for the same purpose?**

## How to Apply It

1. **Why: establish the purpose.** Find the problem and value this feature or structure must provide from the original goal and requirements. Do not use the code's existence as evidence of need or invent a purpose to justify it.
2. **What: define the required outcome.** State the behavior, responsibilities, and success criteria needed to achieve Why. Identify external behavior and constraints that must survive the change, separate from accidental constraints of the current implementation.
3. **How: choose a fitting structure.** Assume the current implementation does not exist, design a structure that satisfies What, then compare it with the current structure. Decide whether to retain, simplify, replace, or remove it. Redesign does not require a full rewrite.
4. **Justify each step from the preceding one.** Explain which What each structural choice satisfies and which Why that What serves. Reconsider a choice when that connection cannot be explained.

Change How when it does not satisfy Why. Do not change Why to justify a chosen How. If new facts change the purpose itself, state the evidence and review from Why again. Before removing or replacing an existing structure, check its reason for existing in history and tests and confirm that the new design still handles the original problem.

## Stop When

You can explain the connection between the required purpose, behavior, responsibilities, constraints, and structural choice, and can decide how to treat the current structure. Verify implementation changes with [Closed Working Loop](../closed-working-loop/SKILL.md).

## Avoid

- Assuming current classes, layers, or tools must remain before review begins.
- Choosing a favored implementation first and inventing a supporting purpose.
- Changing required external behavior or constraints while cleaning structure.
- Discarding all existing implementation merely because you are reasoning from first principles.
