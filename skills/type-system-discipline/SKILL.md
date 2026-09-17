---
name: type-system-discipline
description: Use static types to prevent invalid states and missing cases before runtime.
disable-model-invocation: true
---

# Type System Discipline

When using a static type system, design types to prevent invalid states and missing cases before compilation.

## Problem It Solves

Loose types, mixed primitives, unhandled cases, and careless casts move errors the compiler could prevent into runtime. Types are structure that enforces domain constraints and call contracts, not comments.

## How to Apply It

1. **Make invalid states unrepresentable.** Do not model mutually exclusive fields as a collection of optional values. Use explicit state kinds and values required by each state. Define states and transitions with [Model the Domain](../model-the-domain/SKILL.md).
2. **Distinguish values with different meaning.** Make identifiers, currencies, and times distinct types or value objects when mixing them would be wrong. Validate on construction and trust the resulting contract.
3. **Do not trust external data before parsing.** Validate JSON, CLI arguments, configuration, environment variables, database rows, and network responses at boundaries, then convert them into typed domain values. Follow [Boundary Discipline](../boundary-discipline/SKILL.md).
4. **Do not lie to the type system.** Do not hide errors with casts, unsafe coercion, arbitrary `any`, or unsupported null assertions. Validate at a boundary or improve the model when the compiler cannot prove a condition.
5. **Require every case to be handled.** Use exhaustive matching so that new state kinds reveal unhandled locations at compile time.
6. **Derive types from the authoritative definition.** Do not hand-copy a schema, protocol, or database migration that already owns the shape. Prevent repeated drift structurally with [Encode Lessons in Structure](../encode-lessons-in-structure/SKILL.md).
7. **Strengthen only where needed.** Strengthen types around null checks, fallible operations, and impossible exceptions, but do not add type ceremony that provides no safety.

## Stop When

Types distinguish required states, values, and cases; external input is validated at boundaries; and call contracts hold without type escapes.

## Avoid

- Using loose objects that permit contradictory field combinations as domain states.
- Mixing identifiers and values with different meanings as the same primitive type.
- Removing compiler errors with casts or `any`.
- Making it impossible to find omitted branches when a new state kind is added.
- Adding type hierarchies and generics that add no safety.
