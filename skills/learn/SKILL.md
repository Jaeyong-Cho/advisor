---
name: learn
description: Extract durable decisions, constraints, discoveries, failures, and conventions from the current session into an OKF archive for future agents. Invoke as /learn.
disable-model-invocation: true
---

# Learn

Turn the current session into compact knowledge that helps a fresh agent avoid a wrong decision, a repeated investigation, or a known failure.

Use this skill only with a resolved absolute target archive directory. Archive durable knowledge through [Archive](../archive/SKILL.md). Do not archive a transcript.

## Select Knowledge

Extract a candidate when forgetting it would cause a future agent to make a wrong decision, repeat meaningful investigation, violate a constraint, or lose a reusable explanation.

Classify each candidate as one of these types.

- **Decision.** A chosen approach and the reason it was selected.
- **Constraint.** An invariant, external limit, compatibility rule, or prohibited action.
- **Discovery.** A non-obvious fact about the domain, codebase, component ownership, or external system.
- **Failure.** A rejected approach, its observed failure, and the resolution or remaining boundary.
- **Convention.** A durable team or user rule for implementation, review, delivery, or communication.

Do not archive raw logs, routine test passes, code facts that a future agent can read immediately, transient hypotheses, or generic advice. Keep current task state, temporary TODOs, and unresolved investigation notes in [To Context](../to-context/SKILL.md) instead.

## Extract from the Session

1. Read the available session messages and artifacts. Use only facts that were observed, user-confirmed, or supported by a cited artifact.
2. Write every candidate as one narrow statement. Separate a decision from its rationale. Separate a constraint from the event that revealed it.
3. Record the source artifact, relevant file path, symbol, command result, user decision, or session source that supports the statement.
4. Mark the confidence as high, medium, or low. Archive low-confidence knowledge only when it is explicitly labeled as a provisional discovery and can prevent repeated investigation.
5. Apply the selection test again. Exclude a candidate when the source repository already expresses the fact clearly and the missing context does not change a future decision.

## Shape Each Knowledge Item

Give Archive one pre-qualified concept per distinct item. Archive chooses the existing match or the required category path.

Use this frontmatter in addition to the standard OKF fields.

~~~
---
type: Decision
title: Payment state ownership
description: PaymentOrchestrator owns the payment state across webhook and polling flows.
tags: [payments, state]
scope: payments
statement: PaymentOrchestrator is the payment state source of truth.
reason: Prevent inconsistent state across webhook and polling flows.
evidence:
  - src/payments/PaymentOrchestrator.ts
confidence: high
status: draft
generated: { by: learn/1.0.0, at: <ISO-8601 timestamp> }
sources:
  - id: session-payment-state
    resource: session:<session-topic>
    title: Current development session
---
~~~

Use source-backed body sections that make the item reusable.

~~~
# Statement

<The decision, constraint, discovery, failure, or convention.>

## Why It Matters

<The future decision or failure this knowledge changes.>

## Evidence

<Links or precise references to supporting artifacts.>

## Implications

<What a future agent should do or avoid.>
~~~

Set type to the selected classification. Set scope to the narrowest affected domain or subsystem. Include reason only when it is known. Include last_verified_at only after an actual verification event.

## Archive Integration

Pass the qualified concepts to Archive with the target archive directory. Archive owns similarity search, duplicate prevention, in-place updates, path selection, provenance preservation, and index.md updates.

Use these default paths for new concepts.

~~~
decisions/<scope>/<topic>.md
constraints/<scope>/<topic>.md
discoveries/<scope>/<topic>.md
failures/<scope>/<topic>.md
conventions/<scope>/<topic>.md
~~~

The paths are defaults. Archive may retain the path of a matching existing concept. Every resulting concept must still follow Archive's category, sub-category, and topic structure.

For knowledge whose only source is the current session, use a stable session resource descriptor such as session:<topic>. Add direct file or artifact sources whenever they exist.

## Report

Report the created and updated concepts with their type, path, and one-sentence value. Report excluded material with the reason it was excluded. Identify unresolved or contradictory candidates that need human direction.

## Done When

Every archived item is durable, source-backed, classified, and discoverable through Archive's index. A fresh agent can use the item to make a better decision without replaying the session. Current work state remains outside the durable archive unless the user explicitly asks to preserve it there.
