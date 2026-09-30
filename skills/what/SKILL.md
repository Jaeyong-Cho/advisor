---
name: what
description: Identify what an existing code element, feature, or domain concept is and what contract it provides. Use for questions such as "What is X?" or "What does X do?" when the user needs responsibilities, observable behavior, and boundaries rather than execution flow or design history.
---

# What

Explain the current meaning and contract of a code element, feature, or domain concept. Give the reader a reliable answer to what it is and what it does before descending into implementation details. Use [How](../how/SKILL.md) for execution flow and [Why](../why/SKILL.md) for motivation or history. Apply [Understand Through Abstraction](../principle-understand-through-abstraction/SKILL.md) to inspect contracts before internals.

## Steps

1. **Identify the target.** State the question, the specific symbol or capability, and the scale being described. If the name is ambiguous, inspect likely matches and state the interpretation; ask only when different interpretations would materially change the answer.
2. **Find the contract and evidence.** Locate the definition, public entry points, representative callers, tests, and relevant documentation. Check actual behavior against names and comments. Record source locations for important claims and flag any disagreement between documentation and code.
3. **Describe what exists.** Explain the target's purpose, responsibilities, inputs or triggers, outputs or observable effects, important rules or invariants, and failure conditions. For a larger feature, name its main parts and ownership boundaries. Include only details a caller or maintainer needs to understand the target's role.
4. **State the boundaries.** Clarify what the target owns, what it delegates, and what it does not provide when that distinction prevents a likely misunderstanding. Separate implemented behavior from proposed behavior, and confirmed facts from inference.
5. **Synthesize.** Answer in plain language with a small representative example when it makes the contract concrete. Stop once the reader can identify and use the target without tracing every internal step.

## Output

Use only the sections that answer the question:

```md
# What: <target>

## Definition

## Responsibilities and Contract

## Boundaries

## Where It Lives

## Evidence Gaps
```

Link to specific files and symbols. Do not turn the answer into a source inventory or a line-by-line walkthrough.

## Done When

The reader can say what the target is, what observable behavior it provides, where responsibility lies, and which claims are verified. Follow a newly raised flow question with [How](../how/SKILL.md), or a rationale question with [Why](../why/SKILL.md).
