---
name: next-improvement
description: Recommend the next small, verifiable improvement from the user's friction, goal, and preferred direction. Use when the user wants to decide what to improve next in development or a working process.
---

# Next Improvement

Recommend one next improvement that reduces the user's friction and advances their goal in their preferred direction. Use [Incremental Progress](../principle-incremental-progress/SKILL.md) as the main decision rule. Deliver a bounded recommendation and a way to judge its effect.

This skill selects the next change. [Recommend Options](../recommend-options/SKILL.md) compares approaches to an already selected task; [Bottleneck](../bottleneck/SKILL.md) investigates constraints in an AI-assisted workflow. Do not require a broad audit, session-history analysis, or a complete redesign to make a useful recommendation here.

## Workflow

1. **Understand the friction, goal, and direction.** Reuse facts and preferences established in the conversation. Identify a concrete situation in which the user experiences friction, what repeats or costs effort, the desired outcome, and the trade-offs they prefer. Separate the goal from a suggested solution. Ask only about missing information that could change the recommendation; use a recent example when the friction is vague. Do not invent frequency, impact, or priorities.
2. **Inspect enough to support the recommendation.** Read the relevant code, document, workflow description, or results when accessible. Keep inspection limited to the reported situation and its immediate dependencies. Distinguish observed facts, user reports, and causal hypotheses. If the cause is uncertain enough to change the choice, make the next step a small discriminating observation or experiment.
3. **Find feasible increments.** Consider removal, reuse, simplification, and a focused structural change where warranted. Each candidate must address a specific friction, serve the goal, fit the user's direction, and have an observable outcome. Do not invent alternatives to reach a fixed count or propose new tools merely because they exist.
4. **Choose the next improvement.** Compare credible candidates by goal impact, recurring benefit, effort, change scope, reversibility, and ease of verification. Prefer the smallest complete increment that offers a supported benefit. Explain decisive trade-offs and the evidence that could change the ranking. Avoid arbitrary scores and unsupported estimates. When useful, show a compact comparison of distinct alternatives.
5. **Make the recommendation reviewable.** State the behavior or responsibility to change, required adjacent changes, preserved contracts, and work outside this increment. Explain how the change addresses the friction and advances the goal. Apply abstraction, modeling, or Deep Module only when relevant to that scope. Make the recommended next action concrete without implementing it.
6. **Define feedback and continuation.** Specify what to observe before and after the change, how to check success, and what would justify continuing, adjusting, or stopping. Use the user's existing evidence and measures where available. If no baseline exists, identify the smallest observation needed to establish it; do not manufacture numerical thresholds. Later improvements depend on this result.

Use [Define Goal](../principle-define-goal/SKILL.md) when the outcome is unclear, [Laziness Protocol](../principle-laziness-protocol/SKILL.md) to constrain scope, and [Closed Working Loop](../principle-closed-working-loop/SKILL.md) to define verification. Read additional principles only when a consequential choice needs them.

## Output

Lead with the recommended next improvement and why it fits the user's goal. Include:

- The concrete friction, goal, and preferred direction, with consequential assumptions marked.
- The supporting observation and proposed causal explanation.
- The smallest complete scope, preserved behavior, and work outside the increment.
- The expected benefit, effort or trade-off, and limits of confidence.
- The before-and-after check and evidence that determines the following step.

Scale detail to the decision. Ask a focused question only when an unresolved user preference or requirement prevents a grounded choice. Otherwise give the recommendation with explicit assumptions.

## Scope and Completion

The recommendation is complete when the user can see what to improve next, why it matters, how small the change is, and how to judge the result. Discussion does not prove that the friction has been resolved.

Do not implement or run the proposed experiment unless the user has authorized that follow-up. Carry forward existing authorization without asking again. For an authorized development follow-up, use [Design](../design/SKILL.md) when behavior or structure needs agreement, or [Great Code](../great-code/SKILL.md) for implementation using interface-focused TDD.
