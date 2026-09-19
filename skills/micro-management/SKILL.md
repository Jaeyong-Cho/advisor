---
name: micro-management
description: Collaborate with a human through one small, meaningful change at a time. Use when shared understanding must stay synchronized with implementation. Invoke as /micro-management.
disable-model-invocation: true
---

# Micro Management

Use Micro Management when the human wants to understand every meaningful change while work proceeds.
The aim is shared understanding. Do not optimize for the fastest possible completion.
Treat the human mental model as part of the system state. A change is complete only when the system evidence and the human's understanding are aligned.

## Operating Rule

Make one atomic semantic change per step.
An atomic semantic change is the smallest change that introduces, removes, or verifies one meaningful behavior, rule, concept, or decision. It may touch several files when they serve the same change. It is too large when it requires understanding multiple unrelated ideas.
Use the smallest step when the boundary is uncertain. A direct test that proves the same changed behavior may belong to the step. Do not add unrelated cleanup, refactors, error handling, abstractions, or adjacent fixes.
Reason about the wider goal as needed. Do not execute work beyond the current step.

## Start

Read only enough context to identify the current state and the smallest useful next change.
For a goal that is already one understandable change, state the proposed step and perform it. For a broad, unclear, or consequential goal, state the first proposed step and wait for the human to align on it before changing files.
Do not present a complete implementation plan unless the human asks for one. When a small ordered sketch helps establish the first step, show only the immediate step and the dependency that releases it.

## Each Step

1. State the current behavior, the one change, and why it is the smallest useful change.
2. State what an end user or API consumer will notice. State what the next maintainer will inherit.
3. Perform only that change.
4. Run the narrowest check that can show its effect when a check is available.
5. Report the changed files, evidence, and remaining uncertainty.
6. Propose exactly one next step.
7. Stop and wait for the human to review, question, redirect, or continue.

Do not continue because the next step is obvious. A human response that says to continue authorizes only the proposed next step. A revised request replaces the proposed step.

## When Work Expands

Discovery does not expand the current step.
Finish the stated change when it remains valid. Record a newly discovered issue as the one proposed next step when it materially changes the work. Stop and ask the human when it invalidates the current change or requires a decision.
Do not perform opportunistic refactoring. When a refactor is necessary, make the refactor its own named step before the behavior change it enables.

## Debugging and Design

In debugging, take one observation or one hypothesis-driven experiment at a time. Report the result before proposing another hypothesis.
In design, establish one decision at a time. Start with the problem and boundary. Then progress through the decisions that depend on it. Do not present an entire architecture as an implementation-ready answer before the human has a usable mental model of each material choice.

## Step Format

Use this format when it helps the human assess the step quickly.

### Step N. <small semantic change>

**Before.** The observed current state.

**Change.** The one change in this step.

**Why.** Why this is the smallest useful move.

**Impact.** What the consumer notices and what the maintainer inherits.

After the change, report this.

**Result.** The observed effect and the evidence.

**Next.** One proposed next step.

Then stop.

## Writing the Reply

Write the reply clean as you draft it. A cleanup pass after drafting does not remove these patterns.

- **Short declarative sentences.** One thought per sentence, ended with a period.
- **No long-dash character anywhere.** Write a file-list bullet as a sentence. Write a bold section header as its own sentence.
- **A colon as a mid-sentence connector is also out.** A colon before a list is fine.
- **Terse is not an excuse to drop content.** Include the details, tradeoffs, choices, and open decisions that the step needs.
- **Frame impact for the consumer and the maintainer.** Name who consumes the work and what changes for them. State what the next engineer inherits.
- **Never fabricate a link, citation, or transcript reference.** Link only artifacts produced or read in the session.
- **Every claim carries its evidence or its label in the same sentence.** Use measured, inferred, or guess when it applies. Do not hand the human a check you could run.

## Comments

Write comments cleanly as you write the code. Keep a comment only when the code cannot show a non-obvious reason.
Do not add phase-narrating comments to verification scripts. Let assertion and log strings describe the observed behavior.

## Done When

The human can explain the current change, its reason, and its observed effect without reconstructing hidden work. The next step is explicit and no work has advanced beyond it.
