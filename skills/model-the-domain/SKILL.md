---
name: model-the-domain
description: Represent domain states, rules, and relationships explicitly in the model.
disable-model-invocation: true
---

# Model the Domain

Express domain state, rules, and relationships in data structures and explicit transition rules.

## Problem It Solves

Synchronizing many booleans or checking the same conditions across files makes valid states and rules hard to understand. Choose representations that fit the domain when adding new logic.

## How to Apply It

1. **Identify states and constraints.** Define possible states and transitions, conditions that must always hold, and responsibility for state changes.
2. **Choose structures that fit the need.** Consider a state model for transitions, a map or discriminated type for behavior by kind, and an index for lookup. In a statically typed language, use [Type System Discipline](../type-system-discipline/SKILL.md) to enforce model constraints in types. Fit the actual rules and access patterns instead of following pattern names.
3. **Collect responsibility for the same knowledge.** Do not split by processing order so that the same rules scatter across stages. Coordination code may preserve execution order. Review external boundaries with [Deep Module](../deep-module/SKILL.md).
4. **Check the improvement.** Evaluate whether invalid states, duplicate rules, and synchronization burden decrease. Keep code that is already clear and local, and do not add structure that creates more understanding and change burden than it removes.

## Stop When

You can explain valid states and responsibilities through the model and transition rules, and can verify that real use preserves required behavior and constraints.

## Avoid

- Adding more conditionals or flags that must be updated together for each feature.
- Forcing a class hierarchy or state machine on every problem.
- Reducing conditionals while moving the same complexity into configuration or indirection.
