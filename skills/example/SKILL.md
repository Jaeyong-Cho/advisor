---
name: example
description: Give a concrete example when the user does not understand an explanation or asks for an example. Use the current conversation or named concept to show a specific starting situation, what happens, and the result.
---

# Example

Turn the concept the user is struggling with into one small, concrete case they can follow. Use this when the user says an explanation is unclear, asks "for example?", or invokes `/example`. The goal is understanding, not a broader tutorial.

## Steps

1. **Find the exact point of confusion.** Use the user's question and the preceding explanation to identify the concept or claim that needs an example. If several are possible, choose the most recent relevant one and state what the example illustrates. Ask which concept they mean only when choosing would likely miss their question.
2. **Choose a representative case.** Use familiar, specific names and values. For code or product behavior, inspect the relevant source or documentation when the example claims to show actual behavior. Label a made-up case as illustrative; do not invent real APIs, outputs, or rules.
3. **Walk it through.** Show the starting situation or input, the key action or decision, and the resulting output or state. Map the decisive step back to the original concept in plain language. Include a nearby counterexample only if it resolves the confusion.
4. **Check the lesson.** End with a one-sentence rule the user can apply to a similar case. If part of the explanation remains uncertain, name that limit rather than presenting the example as proof of a broader rule.

## Response shape

```md
**Example:** <specific starting situation>

1. <what happens first>
2. <the decisive step>
3. <the result>

**Why this helps:** <how the example illustrates the concept>
```

Use only the steps needed to make the case clear. Prefer one well-chosen example to several loosely related ones. If the user still cannot follow it, change the example's level of detail or choose a different familiar context instead of repeating the same wording.

## Done When

The user can see how the abstract statement applies to a concrete case and what result it predicts. Do not write or change code unless the user separately requests implementation.
