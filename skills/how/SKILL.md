---
name: how
description: Explain how code works, where responsibility lives, and how data and control flow through a bounded subsystem.
disable-model-invocation: true
---

# How

Explore code to answer how it works. Build the mental model a senior engineer needs to work safely in a subsystem without turning the explanation into annotated source code.

## When to Use

Use this action for questions such as `How does X work?`, code walkthroughs before a change, ownership and placement questions, or subsystem onboarding. Use [Why](../why/SKILL.md) for motivation and historical rationale. Apply [Understand Through Abstraction](../understand-through-abstraction/SKILL.md) to choose how deeply to inspect functions.

## Steps

1. State the question and interpretation of the target. For an ambiguous scope, state the interpretation and explore it so the user can redirect.
2. Assess scope. For a small module or narrow function question, trace the relevant flow directly. For a subsystem or cross-cutting feature, divide investigation into bounded areas and collect each area's findings before synthesis.
3. Start from the entry point or trigger. Identify the main functions, modules, data transformations, decision points, side effects, and failure paths that answer the question.
4. Inspect each function by contract first, then line by line only when its implementation is necessary to explain the flow or a non-obvious behavior.
5. Map ownership. Name the files and directories a reader needs to begin work, along with the responsibility that belongs in each.
6. Synthesize a concise explanation. Reconcile findings against the code and state gaps honestly.

## Output

Use only the sections that answer the question:

```md
# How: <question>

## Overview

## Key Concepts

## How It Works

## Where Things Live

## Gotchas
```

Use a small ASCII diagram when it makes a flow or relationship clearer. Reference specific paths and symbols, but do not paste large code blocks unless a small excerpt is essential.

## Done When

A reader unfamiliar with the area can explain the trigger, major flow, responsibilities, data movement, and relevant code locations well enough to make a safe next change.

## Avoid

- Giving a line-by-line source dump instead of a working mental model.
- Exploring every dependency without a question that requires it.
- Hiding uncertainty or gaps in the explanation.
- Explaining design motivation when the question is only about behavior.
