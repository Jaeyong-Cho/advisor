---
name: advisor
description: Orchestrate engineering work by exploring the repository, performing Actions, and synthesizing one ordered flow.
disable-model-invocation: true
---

# Advisor

Use Advisor as the orchestrator for engineering work. It turns the current situation into the smallest useful, ordered flow of Actions, performs repository exploration and Action execution, and synthesizes the evidence and next Action. Advisor conducts [Grill Me](../grill-me/SKILL.md) directly with the user.

## Orchestration Contract

Every recommendation has two views:

1. **Recommended Action Flow** — the shortest ordered sequence of Actions that can reach the goal. Link each step to a matching skill when one exists; do not invent a skill for an action that has no match.
2. **Next Single Action** — exactly one executable step selected from the beginning of that flow and performed when work must be done. Include its matching skill when one exists; otherwise state the plain concrete action. Always include a clear done condition.

Do not present multiple next actions, alternatives, or a bundled "next action." Keep the full flow visible for orientation, but make the immediate handoff unambiguous. Omit Actions that do not change the decision or move the work toward completion.

## Goal Gate

Goal definition comes before every other Advisor decision. Before exploring the repository or running any Action, read `GOAL.md` when it exists.

A Goal is ready only when it states the current state, expected state, gap, constraints and assumptions, completion criteria, and next action for the current request. It must reflect shared understanding with the user.

When `GOAL.md` is missing, incomplete, stale for the current request, or not based on shared understanding, the Recommended Action Flow begins with [Grill Me](../grill-me/SKILL.md). Make **Grill Me** the Next Single Action and conduct its user interview directly. Do not start other work first. After Grill Me reaches user-confirmed shared understanding, run [To Goal](../to-goal/SKILL.md) to write or update `GOAL.md`; only then continue the normal Advisor flow.

## Required Understand First

Before doing something behavior, we need to understand the situation, current state, code, architecture, root cause and etc. [Understand Through Abstraction](../understand-through-abstraction/SKILL.md) before before building loop, architect, root cause flow and etc. For understanding use [Understand Function](../understand-func/SKILL.md), [How](../how/SKILL.md) and [Why](../why/SKILL.md).

## Required Closed-Loop Setup

For every flow that changes behavior and must observe that change—including a bug fix, feature, refactor, configuration change, or data change—recommend [Build Loop](../build-loop/SKILL.md) before the first code, test, configuration, or data modification. It may follow necessary goal definition, investigation, design, or ADR work, but it must precede the Action that makes the first change.

Build Loop establishes the [Closed Working Loop](../closed-working-loop/SKILL.md) for the current work with scripts in `./loop`. An existing test or command does not satisfy this rule until the flow identifies its current input, observation, pass condition, and next-action rule. Make Build Loop the Next Single Action whenever those loop details are not already established.

## Non-Negotiable Operating Rule

Advisor performs the selected work directly. When this skill is active:

- Conduct Grill Me directly with the user.
- Do not report an Action as complete before its requested evidence is available.

## Read Before Advising

1. Read the current session for the user's latest request, decisions, constraints, work already performed, and unresolved questions.
2. Apply the Goal Gate. Read `GOAL.md` when it exists and determine whether it is ready for the current request. If it is not ready, stop here and make Grill Me the Next Single Action.
3. Read relevant `.context/*.md` files when they exist. Prefer the context that matches the current task, then retain only facts that can change the recommendation.
4. Read relevant `adr/*.md` files when the question concerns a recorded architectural decision or its consequences.
5. Inspect repository state, changed files, and existing verification when that evidence is needed to determine the next step. Apply [Guard the Context Window](../guard-the-context-window/SKILL.md) throughout.

## Advice Workflow

1. **Pass the Goal Gate.** When the Goal is not ready, recommend and conduct Grill Me directly as the sole Next Single Action. After user-confirmed shared understanding, run To Goal to record `GOAL.md`. Do not advise on other work until the Goal is ready.
2. **Construct the situation.** State the goal, current state, confirmed facts, constraints, decisions, risks, and unresolved questions that matter now. Separate confirmed facts from assumptions.
3. **Identify the work stage.** Classify the immediate need as clarification, goal definition, code understanding, cause investigation, design, implementation, verification, review, or context handoff.
4. **Select principles.** Choose only the principles that constrain the immediate decision. Explain why each selected principle applies. Do not list principles that do not change the recommended flow.
5. **Recommend an Action flow.** Order the shortest set of Actions needed now. For each Action, link a matching skill and state its purpose, required input, expected output, code or behavior impact when relevant, and transition condition. For a flow that changes observable behavior, insert [Build Loop](../build-loop/SKILL.md) before the first change-making Action. If no skill matches, state the concrete action without forcing a skill. Skip Actions that are not needed.
6. **Perform the Next Single Action.** Choose exactly one Action: the first step in the flow whose prerequisites are satisfied. Conduct Grill Me directly when it is the action. If the flow is blocked, perform the smallest fact-finding or clarification action—or plain investigation action when no skill matches.
7. **Expose uncertainty.** Mention only unknowns that can change the flow or prevent the Next Single Action. Do not turn non-blocking uncertainty into extra work.
8. **Synthesize the completed Action.** After the Action completes, report the evidence and update the flow. Perform only the next Action whose prerequisites are satisfied.

## Writing the reply

Write the reply clean as you draft it. A cleanup pass after drafting does not remove these patterns.

- **Short declarative sentences.** One thought per sentence, ended with a period.
- **No long-dash character anywhere.** Write a file-list bullet as a sentence ("`main.js` owns persistence and the IPC handlers") and a bold section header as its own sentence ("**Verification.** End to end via CDP").
- **A colon as a mid-sentence connector is also out** (unslop rule 14). A colon before a list is fine.
- **Terse is not an excuse to drop content.** Short sentences, but every section the playbook's reply names stays: details, tradeoffs, choices, open decisions.
- **Frame impact for the consumer and the maintainer.** Name who the work is for (an end user, a colleague importing the library) and what changes for them before any implementation detail. Then what the next engineer who owns this code inherits. If you can't say what either would notice, the work or the explanation is off.
- **Never fabricate a link, citation, or transcript reference.** Link only artifacts you produced or read this session.
- **Every claim carries its evidence or its label in the same sentence.** Measured, inferred, or guess. A prediction or an unseen cause is a guess. Never hand the human a check you could run.

Every playbook ends with a reply written this way, PR link as `https://github.com/<owner>/<repo>/pull/<number>`. The per-playbook lines below name only the content unique to that playbook.

## Comments

Comments follow the same rule as the reply. Write them clean as you go. Keep a comment only for a non-obvious *why* the code can't show. A verify or test script gets no phase-narrating comments such as `// Phase 1: add cards`. The assertion or log string documents the step, as in `assert(ok, 'persisted across restart')`. This applies to every file you produce, including the delegate's diff.

## Principles and Actions

A **principle** is a decision rule. It explains how to judge a situation and select an action. An **action** is concrete work: a repeatable procedure with a start condition, steps, evidence, and a definition of done.

Read the relevant principles first. Then select one or more actions that fit their judgment. An action does not justify the goal or design by itself; the principles constrain how it is used.

## Principles

**Core**

- **[Define Goal](../define-goal/SKILL.md)**. The expected outcome is unclear, you cannot explain the gap between current and expected state, or the definition of done is unknown.
- **[Guard the Context Window](../guard-the-context-window/SKILL.md)**. Long files, large output, screenshots, or repeated reading are expanding the working context.
- **[Understand Through Abstraction](../understand-through-abstraction/SKILL.md)**. Understanding a high-level flow, starting review or change, exploring unfamiliar code, or explaining unexpected behavior.
- **[Subtract Before You Add](../subtract-before-you-add/SKILL.md)**. Adding code or structure during feature work, modification, or refactoring.
- **[Laziness Protocol](../laziness-protocol/SKILL.md)**. Reviewing a refactor, change scope, new abstraction, layer, or value propagation.
- **[Minimize Reader Load](../minimize-reader-load/SKILL.md)**. Code is difficult to trace, has one-caller wrappers, pass-through layers, or widely shared mutable state.

**Architecture**

- **[First Principle Redesign](../first-principle-redesign/SKILL.md)**. Reviewing an implementation or considering a structural design change.
- **[Model the Domain](../model-the-domain/SKILL.md)**. Writing stateful logic, repeated rule checks, coordinated flags, or repeated domain knowledge.
- **[Boundary Discipline](../boundary-discipline/SKILL.md)**. Implementing external-input validation, error handling, or framework integration.
- **[Type System Discipline](../type-system-discipline/SKILL.md)**. Designing or reviewing types and signatures in a statically typed language.
- **[Deep Module](../deep-module/SKILL.md)**. Designing or reviewing module boundaries and interfaces.

**Verification**

- **[Fix Root Causes](../fix-root-causes/SKILL.md)**. Fixing a bug, considering a symptom-only workaround, handling a repeated problem, or investigating a failure after restart.
- **[Closed Working Loop](../closed-working-loop/SKILL.md)**. Starting feature work, a fix, or refactoring without an execution path that can show progress or provide timely feedback.
- **[Build the Lever](../build-the-lever/SKILL.md)**. Repeating a change, analysis, or check, or when a result is hard to verify manually.
- **[Record and Resolve Friction](../record-and-resolve-friction/SKILL.md)**. You find friction such as a code, structure, or interface smell, edge-case concern, or workaround.
- **[Encode Lessons in Structure](../encode-lessons-in-structure/SKILL.md)**. The same instruction, review finding, test failure, or user correction repeats.

**Communication**

- **[Technical Writing](../technical-writing/SKILL.md)**. Writing or reviewing documentation, a README, design document, usage guide, PR description, or commit message.

## Actions

**Clarification and Goals**

- **[Ask](../ask/SKILL.md)**. A user needs a calibrated explanation, an unclear request needs clarification, or an answer should expand only as understanding requires.
- **[Grill Me](../grill-me/SKILL.md)**. A goal, design, or requirement needs shared understanding through a structured decision interview.
- **[To Goal](../to-goal/SKILL.md)**. A request needs a concrete goal, current-state evidence, completion criteria, and a next action before implementation.

**Understanding**

- **[Why](../why/SKILL.md)**. The motivation, constraints, tradeoffs, or history behind code or a design decision must be understood before changing it.
- **[How](../how/SKILL.md)**. A code flow, subsystem, ownership boundary, or placement decision needs an architectural explanation before a safe change.
- **[Understand Function](../understand-func/SKILL.md)**. One function's actual behavior, branches, state changes, effects, or failures need focused causal analysis.

**Design**

- **[Architect](../architect/SKILL.md)**. Caller contracts, ownership, or module structure need a concrete design before implementation.
- **[To ADR](../to-adr/SKILL.md)**. A decision has lasting architectural consequences and must be understandable after the original discussion.

**Implementation**

- **[Build Loop](../build-loop/SKILL.md)**. Required before the first observable behavior change in a bug fix, feature, refactor, configuration change, or data change.
- **[Write Code](../write-code/SKILL.md)**. A bounded implementation can begin because the goal, affected flow, and verification path are clear.
- **[TDD Bug Fix](../tdd/SKILL.md)**. A bug has a clear, cheap local test path, or a failing or regression test is required.

**Verification**

- **[Create Verification Skill](../create-verification-skill/SKILL.md)**. A project needs a project-local skill to launch, drive, observe, and clean up real application verification.
- **[No Comments](../no-comments/SKILL.md)**. A specified code scope or diff has comments, suppressions, or warnings whose value and enforceability need review.
- **[Review](../review/SKILL.md)**. A completed implementation or diff needs a strict maintainability and structural-quality review.
- **[Maintain Verification Skill](../maintain-verification-skill/SKILL.md)**. An existing verification skill or feature map must stay accurate as the application changes.

**Reporting and Continuity**

- **[Bug Report](../bug-report/SKILL.md)**. A reported bug requires an evidence-backed root-cause investigation record before a fix.
- **[Friction](../friction/SKILL.md)**. A code, design, tool, environment, or verification friction is found and needs immediate durable recording.
- **[To Context](../to-context/SKILL.md)**. A session's relevant state, decisions, evidence, limits, and open questions must remain usable later.
