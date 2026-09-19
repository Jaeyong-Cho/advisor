---
name: to-adr
description: Record an architecture decision, its context, alternatives, consequences, and evidence in an Architecture Decision Record.
disable-model-invocation: true
---

# To ADR

Record a durable Architecture Decision Record for a decision that affects structure, boundaries, contracts, dependencies, or future change cost.

## When to Use

Use this action after a meaningful design decision is ready to record. Apply [First Principle Redesign](../principle-first-principle-redesign/SKILL.md) to derive the decision from Why, What, and How. Use [Technical Writing](../principle-technical-writing/SKILL.md) so the record is clear to future readers.

Do not create an ADR for a local implementation detail that is easy to change and has no lasting architectural consequence.

## Steps

1. State the problem, constraints, and forces that require a decision.
2. List the realistic alternatives considered, including retaining the current design when relevant.
3. State the decision in direct language.
4. Explain how the decision satisfies the required outcome and the purpose behind it.
5. Record positive, negative, and neutral consequences, including migration, operational, and verification effects.
6. Link the decision to its evidence, implementation, and validation when those artifacts exist.

## Output

Write one ADR to `adr/{NN}.md` with this structure:

```md
# ADR: <decision>

## Status

## Context

## Decision

## Alternatives Considered

## Consequences

## Evidence and Validation
```

## Done When

A future reader can understand why the decision was necessary, what was chosen, what alternatives were rejected, and what consequences they must account for without reconstructing the original discussion.
