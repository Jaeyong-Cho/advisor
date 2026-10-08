---
name: recommend-options
description: Recommend distinct, feasible options for a user-stated purpose or goal using the relevant principle-* decision rules. Use when the user asks which approach, design, tool, or strategy to choose before taking action.
disable-model-invocation: true
---

# Recommend Options

Help the user choose a way to reach their goal. Principles guide the judgment; they do not replace evidence about the available options or the user's priorities. This skill produces a recommendation, not an implementation.

## Steps

1. **Frame the decision.** State the user's purpose, desired outcome, current situation, constraints, and how success would be recognized. Use [Define Goal](../principle-define-goal/SKILL.md) when the outcome or gap is unclear. Inspect available facts yourself; ask the user only for a missing preference or constraint that could materially change the choice.
2. **Read the relevant principles first.** Use the [Principles index](../../AGENTS.md) when available, or inspect the descriptions of available `principle-*` skills. Select and read the few principles whose stated conditions match this decision. Turn their rules into explicit evaluation criteria or constraints, and name the principles that actually affect the recommendation. Do not load every principle or cite one merely because its name sounds relevant.
3. **Find viable options and proven precedents.** Research the facts needed to judge the choice. Offer materially different ways to meet the goal, including reuse of an existing approach when it is viable. When a mature, long-lived software system provides a relevant precedent, name the system and the specific structure or choice it demonstrates. Explain why that precedent fits this decision and where its context differs; treat it as evidence to consider, not proof that the same choice is right here. Prefer primary documentation or source code for factual claims. Remove options that violate a hard constraint. Do not invent alternatives to reach a fixed number; if only one viable option remains, explain why.
4. **Compare consistently.** Evaluate each option against the same goal and principle-derived criteria. Show the main benefit, cost or effort, risks, reversibility, and evidence needed to verify success where they matter. Separate observed facts from estimates and assumptions. Make any conflict between principles or user priorities visible.
5. **Recommend and bound the uncertainty.** Choose the option that best meets the stated goal and explain the decisive trade-off, including how relevant precedents informed the choice. Say when another option would become preferable. If an unresolved user-owned priority changes the ranking, ask a focused question and give a provisional recommendation. If the uncertainty is factual, investigate it or propose the smallest useful check.

## Output

Use a compact comparison, such as:

```md
## Goal and decision criteria

## Options

| Option | Goal fit | Main benefit | Main cost or risk | Best when |
| --- | --- | --- | --- | --- |

## Recommendation

## What could change the choice
```

Name the relevant principles near the criteria they shaped. Include relevant precedents in the comparison or recommendation with links when sources are available. If no useful precedent applies, say so briefly instead of forcing one. End with the next decision or verification step. Do not implement, purchase, publish, or otherwise act on an option unless the user separately asks for that action.

## Done When

The user can see the feasible choices, the same criteria applied to each, why one is recommended for their goal, and what evidence or preference would change the recommendation.
