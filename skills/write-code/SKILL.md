---
name: write-code
description: Implement one bounded change after the goal, design constraints, and verification path are clear.
disable-model-invocation: true
---

# Write Code

Implement a bounded change that satisfies a defined goal, preserves required contracts, and leaves executable verification evidence.

## When to Use

Use this action after the goal, affected flow, and verification path are clear. Apply [Understand Through Abstraction](../principle-understand-through-abstraction/SKILL.md) before changing unfamiliar code and [Closed Working Loop](../principle-closed-working-loop/SKILL.md) throughout implementation.

## Steps

1. Understand the goal, constraints, preserved behavior, and completion criteria.
2. Trace the affected high-level flow and identify the smallest responsible code locations.
3. Inspect existing patterns, contracts, and tests in those locations before adding new structure.
4. Make the smallest coherent change that fulfills the expected behavior.
5. Apply relevant principles for boundaries, domain modeling, types, reader load, and complexity as the change requires.
6. Run the selected verification path. Inspect the result and revise the change when it does not meet completion criteria.
7. Record the changed behavior, validation performed, and any friction deferred to Chill Mode.

## Output

Leave the implementation, focused verification evidence, and a concise record of behavior changed and known deferred friction.

## Done When

The implementation meets the completion criteria, preserves required contracts, passes the selected verification, and leaves no unrecorded friction discovered during the work.
