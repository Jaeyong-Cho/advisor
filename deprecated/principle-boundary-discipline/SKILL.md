---
name: principle-boundary-discipline
description: Keep external validation and conversion at boundaries so internal logic uses trusted domain values.
disable-model-invocation: true
---

# Boundary Discipline

Collect validation and conversion of external data at system boundaries. Let internal domain logic operate on validated domain values.

## Problem It Solves

Repeating the same validation at every call site makes the actual guarantee unclear. When business decisions mix with frameworks and I/O, they are difficult to understand and verify independently.

## How to Apply It

1. **Define trust boundaries.** Validate and convert external values such as CLI arguments, configuration, and API responses where they enter the system. A type declaration does not replace runtime validation.
2. **Trust established contracts.** Do not repeat conditions that the boundary checked and internal code preserves. Check business constraints that depend on state changes in the domain.
3. **Isolate boundary representations.** Do not spread HTTP requests, database records, or framework objects through domain contracts. Define internal representations with [Model the Domain](../principle-model-the-domain/SKILL.md).
4. **Separate business decisions from I/O.** Express business decisions as pure functions and keep I/O and framework integration in thin adapters. Do not add layers solely to create separation.
5. **Assign error-handling responsibility.** Propagate internal failures with necessary context, then convert them into external responses or exit states at the boundary. Do not hide failure with arbitrary defaults.

## Stop When

The validation point for external input and the internal contract are clear, and you can verify business decisions without the framework.

## Avoid

- Repeating the same null checks and input validation in every function.
- Removing runtime business constraints because code is internal.
- Scattering domain rules through HTTP handlers or framework integration code.
