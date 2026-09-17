---
name: to-context
description: Preserve the relevant state, decisions, goals, and limits of a session in one durable context document.
disable-model-invocation: true
---

# To Context

Create a complete, durable context for a session in one document.

## When to Use

Use this action when work will continue in another session, when a new contributor needs reliable context, or when a task has accumulated decisions and limits that must not be lost. Do not use it to replace the working implementation, design, or verification records themselves.

## Steps

1. Choose `.context/` as the destination directory and choose a numeric prefix and slug for the context document.
2. Write the current situation in the order a future reader needs to understand it: relevant repository state, user goal, decisions, implemented changes, validation, limits, risks, and unresolved questions.
3. Collect facts that help a future AI continue safely and efficiently. Prefer exact paths, symbols, commands, inputs, outputs, and results over general descriptions. Capture relevant repository state, active branch or working-tree changes, entry points, affected files, domain terms, contracts, data shapes, commands run, validation results, environment or tooling constraints, established conventions, decisions and their rationale, known failures, and unresolved questions.
4. Include only facts that can change the next decision, implementation, or verification. Keep large source material out of the record and link to its path and relevant location instead.
5. Distinguish confirmed observations from assumptions where the difference affects the next decision. Do not turn an implementation choice into the goal unless the user made it a requirement.
6. Link to existing artifacts where evidence is needed instead of duplicating large source material.
7. Read the record once as a future AI would. Remove context that does not affect a future decision and add any missing fact, decision, limitation, or unresolved question needed to continue the work.

## Output

Create one file:

```text
.context/{NN}-context-{slug}.md
```

Write a coherent context record. Use headings only when they make the record easier to navigate; do not force fixed categories.

```md
# Context: <session>

<The current situation, relevant decisions, evidence, limits, and open questions.>
```

## Done When

The context file exists and gives a future AI enough of the current situation, facts, decisions, evidence, limits, and open questions to continue work without reconstructing the whole session.

## Avoid

- Presenting assumptions as verified observations.
- Treating an inferred implementation as a user requirement.
- Duplicating full logs, long source files, or other large evidence instead of linking to their locations.
- Mixing material from different sessions or scopes in one context record.
- Recording generic summaries without paths, symbols, commands, evidence, or decision relevance.
