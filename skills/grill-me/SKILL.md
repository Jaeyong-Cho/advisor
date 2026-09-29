---
name: grill-me
description: Establish user-owned goals, reasons, and consequential decisions through focused questions; leave routine method choices to the worker.
disable-model-invocation: true
---

# Grill Me

Interview the user about consequential decisions they own until there is enough shared understanding to proceed. Map dependencies between those decisions, but leave method choices within agreed boundaries to the worker.

## Impact Level and Uncertainty

Before asking, read `references/grill-impact.md`. Apply its decision-authority, impact, uncertainty, and action rules. Classify potential questions by ownership before bringing them to the user. Mark questions actually asked with impact and uncertainty; recommend the smallest safe experiment when uncertainty cannot be resolved by inspection.

## Scope check

If the request bundles unrelated goals or the intended scope changes the outcome, ask which scope the user wants. Otherwise choose a focused working scope within the stated goal; do not make a scope interview a mandatory preflight.

Work in **rounds** when multiple user-owned decisions remain. The **frontier** is the set of decisions whose prerequisites are settled. Ask up to 3 consequential questions per round, numbered with a recommended answer; defer dependent questions to later rounds. Do not ask questions merely to fill a round.

Each question should be formatted like so:
```text
# ❓ Qn — <one precise question?>

<Why this matters, what is already true, and what remains uncertain.>

**Example**
<Concrete scenario, fenced code, or ASCII diagram.>

**Answer with:** <the expected response shape>

-> **Recommendation:** <answer and brief reason>
```

Each round the user answers reshapes the tree: settled decisions push the frontier outward and unblock questions that depended on them. Recompute the frontier and ask the next round. A question whose answer depends on another question still open in this round belongs to a _later_ round, not this one.

Finding _facts_ is your job, never the user's. When a frontier question needs a fact from the environment (filesystem, tools, etc.), dispatch a sub-agent to find it; don't ask the user for anything you could look up yourself. Don't block on it: a running exploration is an unsettled prerequisite, so only the questions downstream of it wait for the sub-agent to report; ask the rest of the frontier now. The _decisions_ are the user's: put each to them and wait.

If needed some experiment to find the question's answer, run the `the experiment action`.

The interview is done when the consequential user-owned frontier is empty. Record material assumptions and open evidence checks. Do not require a final confirmation when the user's answers already establish the goal and boundaries; ask if a consequential interpretation remains disputed.

## Good question framework

Build each question from these parts:

1. **Purpose** — state the goal and why this decision matters.
2. **Grounding** — summarize the relevant evidence, current situation, prior decisions, and constraints.
3. **Gap** — identify the uncertainty or trade-off that remains.
4. **Helpful example (required)** — give one concrete scenario that makes the choice easier to understand.
5. **Focused question (required H1)** — put the complete question at the top as `# ❓ Qn — <actual question?>`. It must be a real question ending in `?`, not a topic or short title.
6. **Response shape** — say whether the useful answer is a choice, comparison, example, priority, constraint, or trade-off.
7. **Recommendation** — for a decision, give the preferred answer and a brief evidence-based reason.
8. **Clarity** — Do not use abbreviation. ELI5 as if asking a question to someone hearing it for the first time.

These are ingredients, not mandatory headings. Use natural prose, combine parts when that reads better, and omit anything that adds no value. Two presentation elements are mandatory for every user-facing question, including scope checks, teach-back, and decision rounds: the question H1 at the top and a helpful example. Give enough context that the user does not have to reconstruct the conversation, but do not bury the question in unrelated detail.

The example must be specific enough for the user to reason from; merely rephrasing the question does not count. Use a fenced code block when syntax, data, requests, or implementation shapes matter. Use an ASCII diagram for flows, relationships, states, boundaries, or alternatives. Do not use Mermaid or image-only diagrams.

```text
# ❓ Qn — <one precise question?>

<Why this matters, what is already true, and what remains uncertain.>

**Example**
<Concrete scenario, fenced code, or ASCII diagram.>

**Answer with:** <the expected response shape>

-> **Recommendation:** <answer and brief reason>
```

Keep numbering and recommendations for decision questions. Calibration and teach-back may use a natural response suggestion instead of a recommendation.

Before sending, verify that the question:

- starts with the complete question as an H1 and ends it with `?`;
- includes a concrete helpful example;
- is answerable from the context provided;
- asks one thing rather than bundling dependent decisions;
- uses plain, neutral language and defines necessary jargon;
- does not ask the user for facts you can inspect yourself;
- makes the consequence of the answer clear.

## When the user can't answer one

"I don't know" / "not sure" / "you decide" is itself a valid answer, not a
stall. For a method choice within established boundaries, choose the recommended
option, record any material assumption, and check the result. If the decision
changes the goal, scope, safety, or a user-owned rule, do not treat silence as
approval; record the affected work as blocked and continue independent work.

Only when the reply is an actual question back — they're asking *you*
something, not declining to decide — answer it first, in layers, with
`[Ask](../ask/SKILL.md)`:

- Core: answer, 1-2 sentences
- Reason: key reasoning, only if they push further
- Detail: examples/edge cases, only if explicitly requested

Re-ask that Qn, unchanged, in the next round alongside whatever else the
frontier opens up. Don't let one unanswered question block recording the
round's other answers.

## Preference
- I don't want to too much over engineering.
- Do not think about the uncertainty not yet encountered.

## Next round

Each round's answers reshape the remaining user-owned decisions. Recompute the frontier, and stop when no consequential question remains.

## Done

The session is done when consequential user-owned decisions are settled or explicitly blocked, with material assumptions and evidence checks visible. Summarize the decisions, including what goal the user wants and why it matters when Grill Me is used as Advisor's goal gate. Confirm that goal and reason before Advisor records `GOAL.md` or starts implementation. Do not require a second confirmation of settled method choices or the later Action flow.
