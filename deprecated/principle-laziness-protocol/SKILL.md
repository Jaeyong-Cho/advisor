---
name: principle-laziness-protocol
description: Choose the smallest maintainable code and structure that satisfies the goal.
disable-model-invocation: true
---

# Laziness Protocol

Choose the smallest code and structure that solves the goal and is least tiring for a person to maintain.

## Problem It Solves

When code can be made quickly, abstractions, layers, and signal passing grow easily. The structure may look plausible at first while increasing the cost for the next person to answer questions and make changes.

## How to Apply It

1. **Compare the smallest solutions.** Compare alternatives that meet the goal by code volume, new concepts, call paths, and change scope. Choose a larger structure only when you can state the complexity it removes.
2. **Consider deletion first.** In improvement and refactoring, find code to remove or merge before adding classes and layers. Follow [Subtract Before You Add](../principle-subtract-before-you-add/SKILL.md) for deletion.
3. **Keep call paths flat.** Shorten a path that requires many pass-through functions and files to answer one question. A deep module hides substantial work behind a simple contract; it is not a deep call chain.
4. **Put a decision in one place.** Do not repeat the same judgment in many places. Make the decision at one source of truth and pass only the necessary result to callers.
5. **Question signal passing.** When a new value or flag must travel through types, configuration, pipelines, or layers, seek a more direct location for the responsibility and its boundary.
6. **Clean small leaks early.** Remove or collect simple pass-through functions, representation leaks, and recurring choices before they grow.

## Stop When

The solution meets the goal while minimizing new code, concepts, call paths, and repeated decisions, and people can change and debug it without excessive effort. Do not choose a smaller change when it omits safety conditions or requirements.

## Avoid

- Hiding meaning or combining code into complex expressions merely to reduce lines.
- Adding pass-through layers and abstractions because the structure looks clean.
- Redesigning an entire system for a small change.
- Removing necessary validation and error handling to appear simple.
