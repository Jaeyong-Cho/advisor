---
name: architect
description: Design caller usage, contracts, and ownership boundaries before implementing a change whose structure is uncertain.
disable-model-invocation: true
---

# Architect

Choose a design that makes the required behavior straightforward to implement and verify.

## Steps

1. Establish the goal and constraints. Use [How](../how/SKILL.md) to trace affected systems and [Why](../why/SKILL.md) when changing existing ownership.
2. Sketch caller usage, then derive types, signatures, responsibilities, and state transitions. Keep pseudocode outside executable paths unless scaffolding is requested.
3. Compare two materially different designs. Apply [Deep Module](../deep-module/SKILL.md), [Model the Domain](../model-the-domain/SKILL.md), and [Type System Discipline](../type-system-discipline/SKILL.md). Explain the chosen tradeoff.
4. Identify preserved contracts, failure behavior, and verification. Record lasting decisions through [To ADR](../to-adr/SKILL.md).
5. For implementation requests, continue through [Write Code](../write-code/SKILL.md). For design-only requests or an explicit checkpoint, deliver the sketch and stop.
6. If repeated implementation workarounds expose a flawed assumption, apply [First Principle Redesign](../first-principle-redesign/SKILL.md) and revise the contract before continuing.

## Output

Provide caller examples, a contract sketch, ownership, alternatives, and verification criteria. Scale detail to the change.

## Done When

The design supports the goal with explicit responsibilities and testable behavior; requested implementation has verification evidence.

## Avoid

- Adding speculative layers or mandatory model orchestration.
- Treating every local edge case as a reason to redesign.
