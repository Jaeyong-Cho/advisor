---
name: to-context
description: Preserve current session context in a dated Google OKF document, checking and cleaning stale information before handoff.
disable-model-invocation: true
---

# To Context

Create a complete, durable context for a session in one document. Write it directly in the current working directory unless the user specifies another destination. Use [Google Open Knowledge Format (OKF) frontmatter](https://github.com/GoogleCloudPlatform/open-knowledge-format/blob/main/SPEC.md) for the document type, topics, and generation time.

## When to Use

Use this action when work will continue in another session, when a new contributor needs reliable context, or when a task has accumulated decisions and limits that must not be lost. Do not use it to replace the working implementation, design, or verification records themselves.

## Steps

1. Use the current working directory as the destination and choose a numeric prefix and slug for the context document. Record the current time with an explicit UTC offset.
2. Read relevant earlier context documents and their OKF frontmatter, if any. Treat `status: deprecated` as historical. Inspect `generated.at` and dates attached to claims. Check old time-sensitive claims against current evidence; a recent `generated.at` alone does not prove the claims are current.
3. Recheck flagged claims against current repository state, source files, or other authoritative evidence. Replace superseded facts with the latest supported state and remove obsolete details that no longer help the next decision. Preserve durable goals and decisions unless newer evidence or the user has changed them. If a claim cannot be checked, label it as an as-of observation or unresolved question instead of presenting it as current.
4. Write the current situation in the order a future reader needs to understand it: relevant repository state, user goal, decisions, implemented changes, validation, limits, risks, and unresolved questions.
5. Collect facts that help a future AI continue safely and efficiently. Prefer exact paths, symbols, commands, inputs, outputs, and results over general descriptions. Capture relevant repository state, active branch or working-tree changes, entry points, affected files, domain terms, contracts, data shapes, commands run, validation results, environment or tooling constraints, established conventions, decisions and their rationale, known failures, and unresolved questions.
6. Include only facts that can change the next decision, implementation, or verification. Keep large source material out of the record and link to its path and relevant location instead. Distinguish confirmed observations from assumptions. Do not turn an implementation choice into the goal unless the user made it a requirement.
7. Add parseable OKF YAML frontmatter. Set `type: Context`, a useful `title` and `description`, concise `tags` for the document's topics, and `generated` with the actual producer and time of the last meaningful content change. Use an OKF actor name (`<producer>/<version>`, `human:<id>`, or `process:<id>`) and an ISO 8601 datetime with an explicit UTC offset.
8. Read the record once as a future AI would. Remove stale or irrelevant context, check that evidence links and dates support the surviving claims, and add any missing fact, decision, limitation, or unresolved question needed to continue the work.

## Output

Create one file:

```text
<current-directory>/{NN}-context-{slug}.md
```

Write a coherent context record. Use headings only when they make the record easier to navigate; do not force fixed categories. Replace the example values below with actual values. Omit optional fields when their values are unknown or inapplicable.

```md
---
type: Context
title: "<session or topic>"
description: "<one-sentence handoff summary>"
tags: ["<topic>", "<subtopic>"]
generated: { by: "<producer>/<version>", at: "<ISO 8601 datetime with UTC offset>" }
---

# Context: <session>

<The current situation, relevant decisions, evidence, limits, and open questions.>
```

## Done When

The context file exists with valid OKF frontmatter and gives a future AI enough current facts, decisions, evidence, limits, and open questions to continue work without reconstructing the whole session. Outdated or superseded claims have been checked, updated, removed, or explicitly marked uncertain.

## Avoid

- Presenting assumptions as verified observations.
- Treating an inferred implementation as a user requirement.
- Duplicating full logs, long source files, or other large evidence instead of linking to their locations.
- Mixing material from different sessions or scopes in one context record.
- Recording generic summaries without paths, symbols, commands, evidence, or decision relevance.
- Treating document creation time as proof that all claims are fresh, or redating an old claim without checking it.
