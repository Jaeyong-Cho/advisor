---
name: principle-incremental-progress
description: Choose a clear improvement direction and advance through small, complete, verifiable changes when planning development, refactoring, or workflow improvements. Apply the Boy Scout Rule to improve touched code incrementally.
---

# Incremental Progress

Set a useful direction, choose the smallest complete change that advances it, and verify the effect before choosing the next change. Prefer improvements that reduce recurring friction or make subsequent changes easier. Build larger benefits through verified increments.

## Problem It Solves

A broad redesign delays feedback and combines changes whose effects are hard to distinguish. Small edits can also consume effort without improving the user's outcome. Progress requires both a meaningful direction and a change whose benefit can be observed.

## How to Apply It

1. **Define the direction.** Use [Define Goal](../principle-define-goal/SKILL.md) to connect the current friction to a desired outcome. State what should improve, what must remain true, and what evidence would show progress. Keep the direction separate from a preferred implementation.
2. **Select a small, complete increment.** Choose one behavior, rule, interface, or workflow step whose improvement can be checked independently. Keep changes needed to preserve its invariants and contracts together. Size the increment by its responsibility, impact, and verification burden rather than line count alone.
3. **Prefer useful leverage.** Prioritize changes that address frequent friction, remove repeated decisions, simplify common use, or lower the cost of the next necessary change. Prefer removal and reuse before new structure. Label expected benefits as hypotheses until observed; do not add speculative capabilities to promise future value.
4. **Design within the increment.** Apply abstraction, domain modeling, and [Deep Module](../principle-deep-module/SKILL.md) to the selected responsibility. Keep unrelated cleanup and system redesign outside the change. Widen the increment only when a concrete requirement or shared invariant makes the smaller scope incomplete.
5. **Verify and learn.** Use [Closed Working Loop](../principle-closed-working-loop/SKILL.md) to compare the result with the starting state under relevant conditions. Check both the intended improvement and preserved behavior. A passing test proves the behavior it covers; claims about speed, effort, or usability need corresponding observations.
6. **Choose the next increment from evidence.** Continue, adjust, or undo the approach based on the observed result. Treat later steps as conditional possibilities rather than committing to a full roadmap before feedback.

## Leave Touched Code Better

Apply the Boy Scout Rule during ordinary development: leave the code you work on a little easier to understand, change, or verify than you found it. Improving maintainability is a valid direction even when no new feature or explicit user complaint drives the change.

- Start with code already touched by the task or an explicitly selected responsibility. Look for a concrete local improvement, such as a clearer name, confirmed dead-code removal, a simpler branch, or removal of a redundant pass-through call.
- Choose an improvement that reduces a demonstrated reading, maintenance, or verification burden. Do not force cosmetic changes or extra abstractions merely to say that cleanup happened.
- Preserve observable behavior and required contracts. Refactor while relevant tests are green and rerun them afterward. Describe the structural improvement separately from the evidence that behavior was preserved.
- Keep the cleanup small enough to review and verify within the current increment. If it requires broader ownership changes or unrelated files, treat it as a separate proposed increment. Repeated local improvements can accumulate across future visits without requiring a full-codebase cleanup now.

## Stop When

During planning, the direction, smallest complete increment, and way to judge its effect are explicit. After execution, the increment has a verified outcome and its required contracts remain intact. State what improved, what remains uncertain, and which evidence supports the next step. If no useful change is supported, choose a small observation or experiment before proposing a redesign.

## Avoid

- Treating a small diff or completed task as proof of useful progress.
- Splitting a coherent responsibility into incomplete pieces or shifting coordination to callers.
- Combining unrelated improvements so their effects cannot be judged separately.
- Promising that every small change will have a large immediate benefit.
- Repeating the same approach when observations show no progress toward the goal.
- Using the Boy Scout Rule to justify unbounded cleanup or changes to unfamiliar code.
