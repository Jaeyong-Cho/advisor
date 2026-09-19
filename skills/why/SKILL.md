---
name: why
description: Investigate the motivation, constraints, and tradeoffs that led to a code or design decision.
disable-model-invocation: true
---

# Why

Investigate why code or a design has its current shape. Explain the forces that led to it, not only its runtime behavior.

## When to Use

Use this action for design rationale, a historical tradeoff, defensive code, a regression, a postmortem, a data-backed threshold, or before replacing an unfamiliar structure. Use [How](../how/SKILL.md) for runtime behavior and code flow. Apply [First Principle Redesign](../principle-first-principle-redesign/SKILL.md) when the findings will guide a structural change.

## Steps

1. State the target and the question. If the target is ambiguous, state the most likely interpretation and investigate it so the user can redirect.
2. Anchor the investigation in concrete code: record relevant paths, symbols, and line ranges. Inspect the last changes affecting the target and linked change discussions when available.
3. Gather evidence from available sources. Consider source history, issue records, design documents, team discussions, operational data, error tracking, and product data. Record unavailable sources as evidence gaps instead of silently assuming they contain nothing.
4. Separate confirmed facts from reasonable inferences and unresolved questions. Do not treat the newest change as the complete rationale when the code may have accumulated through several decisions.
5. Compare competing explanations when the evidence supports more than one. State why one explanation is better supported or leave the result uncertain.
6. If a change follows, turn the findings into Preserve, Change, Avoid, and Risk constraints before planning it.

## Output

Write an investigation record with these sections:

```md
# Why: <question>

## Code Anchor

## Confirmed Findings

## Reasonable Inferences

## Competing Hypotheses

## Evidence Gaps

## Sources Consulted

## Confidence

## Preserve, Change, Avoid, and Risk
```

## Done When

The record distinguishes evidence, inference, and unknowns; names consulted and unavailable sources; and gives enough rationale to preserve or change the target deliberately.

## Avoid

- Explaining runtime behavior when the question is about motivation.
- Treating recent code as the only authoritative rationale.
- Presenting inference as fact.
- Omitting unavailable evidence sources and implying complete coverage.
