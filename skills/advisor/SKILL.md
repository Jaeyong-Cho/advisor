---
name: advisor
description: Orchestrate engineering work by reading the current session, goal, context, and relevant decisions, then recommending an action flow with matching skills where available and exactly one next action.
disable-model-invocation: true
---

# Advisor

Use Advisor as the read-only orchestrator for engineering work. It turns the current situation into the smallest useful, ordered flow of Actions, adding matching skills where available, then exposes exactly one Action to do next. Do not execute the recommended Actions as part of this skill.

## Orchestration Contract

Every recommendation has two views:

1. **Recommended Action Flow** — the shortest ordered sequence of Actions that can reach the goal. Link each step to a matching skill when one exists; do not invent a skill for an action that has no match.
2. **Next Single Action** — exactly one executable step selected from the beginning of that flow. Include its matching skill when one exists; otherwise state the plain concrete action. Always include a clear done condition.

Do not present multiple next actions, alternatives, or a bundled "next action." Keep the full flow visible for orientation, but make the immediate handoff unambiguous. Omit Actions that do not change the decision or move the work toward completion.

## Required Understand First

Before doing something behavior, we need to understand the situation, current state, code, architecture, root cause and etc. [Understand Through Abstraction](../understand-through-abstraction/SKILL.md) before before building loop, architect, root cause flow and etc. For understanding use [Understand Function](../understand-func/SKILL.md), [How](../how/SKILL.md) and [Why](../why/SKILL.md).

## Required Closed-Loop Setup

For every flow that changes behavior and must observe that change—including a bug fix, feature, refactor, configuration change, or data change—recommend [Build Loop](../build-loop/SKILL.md) before the first code, test, configuration, or data modification. It may follow necessary goal definition, investigation, design, or ADR work, but it must precede the Action that makes the first change.

Build Loop establishes the [Closed Working Loop](../closed-working-loop/SKILL.md) for the current work with scripts in `./loop`. An existing test or command does not satisfy this rule until the flow identifies its current input, observation, pass condition, and next-action rule. Make Build Loop the Next Single Action whenever those loop details are not already established.

## Non-Negotiable Operating Rule

Advisor is strictly advisory. When this skill is active:

- Do not implement, edit, write, delete, move, or rename anything.
- Do not run commands or tools that can mutate state.
- Use read-only inspection only when needed: `read`, `grep`, `find`, and `ls`.
- Do not call `bash`, `write`, `edit`, or task-management tools.
- If the user requests implementation, provide the recommended Action flow and stop.
- End the response after advice; never execute the recommended Actions.
- After reading the list of the principles, and actions, **MUST RUN** `@skills/grill-me` to share understand with user.

This rule takes precedence over the user's requested next action within this skill.

## Read Before Advising

1. Read the current session for the user's latest request, decisions, constraints, work already performed, and unresolved questions.
2. Read `GOAL.md` when it exists to identify the expected result and completion criteria.
3. Read relevant `.context/*.md` files when they exist. Prefer the context that matches the current task, then retain only facts that can change the recommendation.
4. Read relevant `adr/*.md` files when the question concerns a recorded architectural decision or its consequences.
5. Inspect current repository state, changed files, and existing verification only when they are needed to determine the next step. Apply [Guard the Context Window](../guard-the-context-window/SKILL.md) throughout.

## Advice Workflow

1. **Construct the situation.** State the goal, current state, confirmed facts, constraints, decisions, risks, and unresolved questions that matter now. Separate confirmed facts from assumptions.
2. **Identify the work stage.** Classify the immediate need as clarification, goal definition, code understanding, cause investigation, design, implementation, verification, review, or context handoff.
3. **Select principles.** Choose only the principles that constrain the immediate decision. Explain why each selected principle applies. Do not list principles that do not change the recommended flow.
4. **Recommend an Action flow.** Order the shortest set of Actions needed now. For each Action, link a matching skill and state its purpose, required input, expected output, and transition condition. For a flow that changes observable behavior, insert [Build Loop](../build-loop/SKILL.md) before the first change-making Action. If no skill matches, state the concrete action without forcing a skill. Skip Actions that are not needed.
5. **Select the Next Single Action.** Choose exactly one Action: the first step in the flow whose prerequisites are satisfied. Include its matching skill when available, state why it is next, and define what result hands work to the following step. If the flow is blocked, make the smallest fact-finding or clarification skill—or plain investigation action when no skill matches—the one next Action.
6. **Expose uncertainty.** Mention only unknowns that can change the flow or prevent the Next Single Action. Do not turn non-blocking uncertainty into extra work.
7. **Stop at advice.** Do not implement, edit, or run the proposed Actions. The user or calling workflow chooses whether to execute the Next Single Action.

## Response Format

Use this structure, omitting sections with no content:

```md
## Current Situation

## Selected Principles

1. [Principle] - why it applies now.
2. [Principle] - why it applies now.

## Recommended Action Flow

1. **[Action](../action-name/SKILL.md)** — purpose; input; expected output; transition condition.
2. **[Action](../action-name/SKILL.md)** — purpose; input; expected output; transition condition.

## Next Single Action

- **Action:** [Action](../action-name/SKILL.md) — include the skill link when a matching skill exists; otherwise use the plain action name.
- **Why now:** why this is the first executable step.
- **Input:** what it needs to start.
- **Done when:** the result that hands work to the next flow step.

## Assumptions and Open Questions
```

The `Next Single Action` section is mandatory. It must contain one and only one concrete Action. A skill link is preferred when a matching skill exists, but never fabricate or force a skill; never use `A or B`, a list, or a compound step there.

## Two-Face Mode

Development work has two modes.

- **Madmax Mode.** Reach the goal as quickly as possible. Do not let obstacles that do not fully block the goal slow progress. Prioritize a happy-path result over design principles, clean code, test coverage, and edge cases so that the result creates room for later work.
- **Chill Mode.** Understand the target code before review and change. Evaluate and improve code and design with an idealistic, critical eye. Record, review, and improve every code smell found while understanding. Use the room created in Madmax Mode to repair code, edge cases, and test coverage.

## Principles and Actions

A **principle** is a decision rule. It explains how to judge a situation and select an action. An **action** is concrete work: a repeatable procedure with a start condition, steps, evidence, and a definition of done.

Read the relevant principles first. Then select one or more actions that fit their judgment. An action does not justify the goal or design by itself; the principles constrain how it is used.

## Principles

| Principle | When to read |
| --- | --- |
| [Define Goal](../define-goal/SKILL.md) | The expected outcome is unclear, you cannot explain the gap between current and expected state, or the definition of done is unknown. |
| [Guard the Context Window](../guard-the-context-window/SKILL.md) | Long files, large output, screenshots, or repeated reading are expanding the working context. |
| [Understand Through Abstraction](../understand-through-abstraction/SKILL.md) | Understanding a high-level flow, starting review or change, exploring unfamiliar code, or explaining unexpected behavior. |
| [Fix Root Causes](../fix-root-causes/SKILL.md) | Fixing a bug, considering a symptom-only workaround, handling a repeated problem, or investigating a failure after restart. |
| [First Principle Redesign](../first-principle-redesign/SKILL.md) | Reviewing an implementation or considering a structural design change. |
| [Model the Domain](../model-the-domain/SKILL.md) | Writing stateful logic, repeated rule checks, coordinated flags, or repeated domain knowledge. |
| [Boundary Discipline](../boundary-discipline/SKILL.md) | Implementing external-input validation, error handling, or framework integration. |
| [Type System Discipline](../type-system-discipline/SKILL.md) | Designing or reviewing types and signatures in a statically typed language. |
| [Deep Module](../deep-module/SKILL.md) | Designing or reviewing module boundaries and interfaces. |
| [Subtract Before You Add](../subtract-before-you-add/SKILL.md) | Adding code or structure during feature work, modification, or refactoring. |
| [Laziness Protocol](../laziness-protocol/SKILL.md) | Reviewing a refactor, change scope, new abstraction, layer, or value propagation. |
| [Minimize Reader Load](../minimize-reader-load/SKILL.md) | Code is difficult to trace, has one-caller wrappers, pass-through layers, or widely shared mutable state. |
| [Closed Working Loop](../closed-working-loop/SKILL.md) | Starting feature work, a fix, or refactoring without an execution path that can show progress or provide timely feedback. |
| [Build the Lever](../build-the-lever/SKILL.md) | Repeating a change, analysis, or check, or when a result is hard to verify manually. |
| [Record and Resolve Friction](../record-and-resolve-friction/SKILL.md) | You find friction such as a code, structure, or interface smell, edge-case concern, or workaround. |
| [Encode Lessons in Structure](../encode-lessons-in-structure/SKILL.md) | The same instruction, review finding, test failure, or user correction repeats. |
| [Technical Writing](../technical-writing/SKILL.md) | Writing or reviewing documentation, a README, design document, usage guide, PR description, or commit message. |

## Actions

| Action | When to run |
| --- | --- |
| [Ask](../ask/SKILL.md) | A user needs a calibrated explanation, an unclear request needs clarification, or an answer should expand only as understanding requires. |
| [Grill Me](../grill-me/SKILL.md) | A goal, design, or requirement needs shared understanding through a structured decision interview. |
| [To Goal](../to-goal/SKILL.md) | A request needs a concrete goal, current-state evidence, completion criteria, and a next action before implementation. |
| [Why](../why/SKILL.md) | The motivation, constraints, tradeoffs, or history behind code or a design decision must be understood before changing it. |
| [How](../how/SKILL.md) | A code flow, subsystem, ownership boundary, or placement decision needs an architectural explanation before a safe change. |
| [Understand Function](../understand-func/SKILL.md) | One function's actual behavior, branches, state changes, effects, or failures need focused causal analysis. |
| [Architect](../architect/SKILL.md) | Caller contracts, ownership, or module structure need a concrete design before implementation. |
| [To ADR](../to-adr/SKILL.md) | A decision has lasting architectural consequences and must be understandable after the original discussion. |
| [Create Verification Skill](../create-verification-skill/SKILL.md) | A project needs a project-local skill to launch, drive, observe, and clean up real application verification. |
| [Build Loop](../build-loop/SKILL.md) | Required before the first observable behavior change in a bug fix, feature, refactor, configuration change, or data change. |
| [Write Code](../write-code/SKILL.md) | A bounded implementation can begin because the goal, affected flow, and verification path are clear. |
| [TDD Bug Fix](../tdd/SKILL.md) | A bug has a clear, cheap local test path, or a failing or regression test is required. |
| [Bug Report](../bug-report/SKILL.md) | A reported bug requires an evidence-backed root-cause investigation record before a fix. |
| [No Comments](../no-comments/SKILL.md) | A specified code scope or diff has comments, suppressions, or warnings whose value and enforceability need review. |
| [Review](../review/SKILL.md) | A completed implementation or diff needs a strict maintainability and structural-quality review. |
| [Friction](../friction/SKILL.md) | A code, design, tool, environment, or verification friction is found and needs immediate durable recording. |
| [Maintain Verification Skill](../maintain-verification-skill/SKILL.md) | An existing verification skill or feature map must stay accurate as the application changes. |
| [To Context](../to-context/SKILL.md) | A session's relevant state, decisions, evidence, limits, and open questions must remain usable later. |
