---
name: learn
description: Extract durable decisions, constraints, discoveries, failures, and conventions from the current session into a user-specified file for future agents. Invoke as /learn.
disable-model-invocation: true
---

# Learn

Write compact knowledge from the current session to a resolved target file. The result helps a fresh agent avoid a wrong decision, a repeated investigation, or a known failure.

Read the target file first when it exists. Preserve its useful structure and update the relevant material in place. When it does not exist, create a concise Markdown document that fits the session topic.

## Select Knowledge

Write an item when forgetting it would cause a future agent to make a wrong decision, repeat meaningful investigation, violate a constraint, or lose a reusable explanation.

Classify each item when the classification helps retrieval.

- **Decision.** A chosen approach and why it was selected.
- **Constraint.** An invariant, external limit, compatibility rule, or prohibited action.
- **Discovery.** A non-obvious fact about the domain, codebase, component ownership, or external system.
- **Failure.** A rejected approach, its observed failure, and the resolution or remaining boundary.
- **Convention.** A durable team or user rule for implementation, review, delivery, or communication.

Do not save raw logs, routine test passes, code facts that a future agent can read immediately, transient hypotheses, or generic advice. Write current task state, temporary TODOs, and unresolved investigation notes only when the user asks for a handoff.

## Extract from the Session

1. Read the available session messages and artifacts.
2. Use only facts that were observed, user-confirmed, or supported by a referenced artifact.
3. Write each item as one narrow statement. Keep the decision separate from its rationale. Keep a constraint separate from the event that revealed it.
4. Include the source artifact, relevant file path, symbol, command result, or user decision that supports the item.
5. Mark a claim as inferred or provisional when evidence does not establish it. Exclude it when it cannot affect a future decision.
6. Exclude a fact when the repository already expresses it clearly and the missing context does not change a future decision.

## Write the File

Use the file's established structure when it exists. Otherwise, use headings only when they make the learning easier to retrieve.

For each item, record the statement and the reason it matters. Include rationale, evidence, confidence, scope, and implications when they materially affect future work. Link to repository artifacts instead of duplicating code, logs, or large source content.

Keep items distinct. Update an existing item when the session adds evidence, corrects it, or changes its implications. Do not append a duplicate statement under a new heading.

## Report

Report the target file, each created or updated item, and its one-sentence value. Report excluded material only when its exclusion could surprise the user.

## Done When

The target file contains only durable, evidence-backed learning that a fresh agent can use without replaying the session.
