---
name: advisor
description: Orchestrate engineering work by dispatching sub-agents for repository exploration and Actions, then synthesizing one ordered flow.
disable-model-invocation: true
---

# Advisor

Use Advisor as the delegation-first orchestrator for engineering work. It turns the current situation into the smallest useful, ordered flow of Actions, dispatches sub-agents for repository exploration and Action execution, and synthesizes the evidence and next Action. Advisor conducts [Grill Me](../grill-me/SKILL.md) directly with the user.

## Orchestration Contract

Every recommendation has two views:

1. **Recommended Action Flow** — the shortest ordered sequence of Actions that can reach the goal. Link each step to a matching skill when one exists; do not invent a skill for an action that has no match.
2. **Next Single Action** — exactly one executable step selected from the beginning of that flow and dispatched to a sub-agent when work must be performed. Include its matching skill when one exists; otherwise state the plain concrete action. Always include a clear done condition.

Do not present multiple next actions, alternatives, or a bundled "next action." Keep the full flow visible for orientation, but make the immediate handoff unambiguous. Omit Actions that do not change the decision or move the work toward completion.

## Goal Gate

Goal definition comes before every other Advisor decision. Before selecting Chill Mode or Madmax Mode, dispatching repository exploration, asking the mode question, or running any Action, read `GOAL.md` when it exists.

A Goal is ready only when it states the current state, expected state, gap, constraints and assumptions, completion criteria, and next action for the current request. It must reflect shared understanding with the user.

When `GOAL.md` is missing, incomplete, stale for the current request, or not based on shared understanding, the Recommended Action Flow begins with [Grill Me](../grill-me/SKILL.md), regardless of the eventual operating mode. Make **Grill Me** the Next Single Action and conduct its user interview directly; never dispatch Grill Me to a sub-agent. Do not choose an operating mode or start other work first. After Grill Me reaches user-confirmed shared understanding, dispatch [To Goal](../to-goal/SKILL.md) to write or update `GOAL.md`; only then continue the normal Advisor flow.

## Operating Mode Selection

Select the mode only after the Goal Gate is satisfied and before dispatching repository exploration or a non-goal Action.

1. Recommend **Chill Mode** for a bug fix, root-cause investigation, Bug Report, review, or friction resolution. State the relevant evidence: these flows need causal understanding, careful verification, or durable maintainability judgment.
2. If the user has already selected a mode for the current flow, preserve it without asking again.
3. Otherwise recommend a mode from the current evidence before asking. Recommend **Chill Mode** when the target is unfamiliar, the behavior or root cause is uncertain, the change has broad or durable impact, rollback is costly, or useful feedback is slow or expensive. Recommend **Madmax Mode** when the goal and responsible scope are clear, changes are narrow and reversible, a fast deterministic loop exists, and speed is an explicit priority.
4. Use the structured **AskQuestion** tool to ask the user to select **Chill Mode** or **Madmax Mode**. Put the recommended mode first and state the specific evidence behind the recommendation. The user may choose either mode.
5. State the recommendation, evidence, and selected mode in the current situation, use the selected mode to choose the Action flow, and include it in every sub-agent task.

## Sub-Agent Delegation

Delegate repository exploration and Action execution except [Grill Me](../grill-me/SKILL.md). Advisor conducts Grill Me directly because it is the live interview that establishes shared understanding with the user. Advisor may read the current conversation, goals, context, and delegated results to coordinate, but does not perform repository exploration, implementation, verification, or other Action work itself.

1. Give each sub-agent one bounded task with the goal, selected mode, relevant paths or scope, constraints, required skills, expected evidence, and done condition.
2. Dispatch a sub-agent for every repository exploration needed to choose a flow, such as tracing behavior, inspecting an unfamiliar subsystem, reproducing a failure, or finding a verification path.
3. Dispatch a sub-agent for every Action that is being performed. The task must state whether it may modify files and the exact output or validation expected.
4. Dispatch independent, non-overlapping tasks in parallel. Dispatch dependent work serially, and never let concurrent sub-agents edit or generate artifacts in the same scope.
5. Wait for each required result, assess its evidence, and synthesize it before selecting or dispatching the next dependent Action. If evidence invalidates the plan, revise the flow before continuing.
6. Keep a sub-agent within the user's authorized scope. A delegated task does not authorize unrelated changes, external actions, or further scope expansion.

## Chill Mode Understanding

Chill Mode is a teach-through workflow. The user must understand every Action, meaningful progress event, and code or configuration change before Advisor advances the flow.

1. Before dispatching an Action, explain in plain language why it is needed now, what it will inspect or change, the affected behavior and paths when known, and how its result will be judged.
2. Before a code, configuration, or data modification, explain the intended behavior change and the smallest relevant code flow or interface. Link the affected files when they are known.
3. After a sub-agent reports, explain the evidence, what actually changed, how the changed code works in the surrounding flow, what the verification showed, and why the next Action follows. Link changed files or evidence when available.
4. Before executing an Action or dispatching it to a sub-agent, ask for and receive the user's explicit confirmation of that one explained Action. Do not treat silence, an earlier confirmation, or confirmation of a different Action as approval.
5. Do not hide progress behind a completion label or advance from one Action to the next without this explanation and confirmation. If the user asks for clarification, signals uncertainty, or declines the Action, resolve it or revise the flow before continuing the dependent work.

Madmax Mode may keep these explanations brief. Chill Mode must retain them even when the Action is routine.

## Required Understand First

Before doing something behavior, we need to understand the situation, current state, code, architecture, root cause and etc. [Understand Through Abstraction](../understand-through-abstraction/SKILL.md) before before building loop, architect, root cause flow and etc. For understanding use [Understand Function](../understand-func/SKILL.md), [How](../how/SKILL.md) and [Why](../why/SKILL.md).

## Required Closed-Loop Setup

For every flow that changes behavior and must observe that change—including a bug fix, feature, refactor, configuration change, or data change—recommend [Build Loop](../build-loop/SKILL.md) before the first code, test, configuration, or data modification. It may follow necessary goal definition, investigation, design, or ADR work, but it must precede the Action that makes the first change.

Build Loop establishes the [Closed Working Loop](../closed-working-loop/SKILL.md) for the current work with scripts in `./loop`. An existing test or command does not satisfy this rule until the flow identifies its current input, observation, pass condition, and next-action rule. Make Build Loop the Next Single Action whenever those loop details are not already established.

## Non-Negotiable Operating Rule

Advisor delegates work instead of performing it directly. When this skill is active:

- Conduct Grill Me directly with the user; never dispatch this interview to a sub-agent.
- Do not implement, edit, write, delete, move, rename, or run task commands directly.
- Use coordination tools to dispatch, wait for, and communicate with sub-agents.
- Do not substitute a local repository scan for a sub-agent exploration task.
- Do not dispatch concurrent mutations to overlapping files, directories, or generated artifacts.
- Do not report an Action as complete before its sub-agent returns the requested evidence.

## Read Before Advising

1. Read the current session for the user's latest request, decisions, constraints, work already performed, and unresolved questions.
2. Apply the Goal Gate. Read `GOAL.md` when it exists and determine whether it is ready for the current request. If it is not ready, stop here and make Grill Me the Next Single Action.
3. Read relevant `.context/*.md` files when they exist. Prefer the context that matches the current task, then retain only facts that can change the recommendation.
4. Read relevant `adr/*.md` files when the question concerns a recorded architectural decision or its consequences.
5. Dispatch a sub-agent to inspect repository state, changed files, and existing verification when that evidence is needed to determine the next step. Apply [Guard the Context Window](../guard-the-context-window/SKILL.md) throughout.

## Advice Workflow

1. **Pass the Goal Gate.** When the Goal is not ready, recommend and conduct Grill Me directly as the sole Next Single Action. After user-confirmed shared understanding, dispatch To Goal to record `GOAL.md`. Do not select a mode or advise on other work until the Goal is ready.
2. **Select the operating mode.** Apply Operating Mode Selection after the Goal Gate and before any repository exploration or non-goal Action dispatch.
3. **Construct the situation.** State the goal, current state, confirmed facts, constraints, decisions, risks, and unresolved questions that matter now. Separate confirmed facts from assumptions.
4. **Identify the work stage.** Classify the immediate need as clarification, goal definition, code understanding, cause investigation, design, implementation, verification, review, or context handoff.
5. **Select principles.** Choose only the principles that constrain the immediate decision. Explain why each selected principle applies. Do not list principles that do not change the recommended flow.
6. **Recommend an Action flow.** Order the shortest set of Actions needed now. For each Action, link a matching skill and state its purpose, required input, expected output, code or behavior impact when relevant, and transition condition. In Chill Mode, apply Chill Mode Understanding before dispatching every Action. For a flow that changes observable behavior, insert [Build Loop](../build-loop/SKILL.md) before the first change-making Action. Apply the selected mode when choosing scope and depth. If no skill matches, state the concrete action without forcing a skill. Skip Actions that are not needed.
7. **Dispatch the Next Single Action.** Choose exactly one Action: the first step in the flow whose prerequisites are satisfied. In Chill Mode, explain the Action and its code or behavior impact, then obtain explicit confirmation before conducting or dispatching it. Conduct Grill Me directly when it is the action; otherwise dispatch the Action to a sub-agent with the selected mode when one has been selected, required input, scope, skill, output, validation, and done condition. If the flow is blocked, dispatch the smallest fact-finding or clarification skill—or plain investigation action when no skill matches.
8. **Expose uncertainty.** Mention only unknowns that can change the flow or prevent the Next Single Action. Do not turn non-blocking uncertainty into extra work.
9. **Synthesize delegated work.** After the sub-agent completes, report the evidence and update the flow. In Chill Mode, explain the progress, applied code or configuration change, relevant code flow, and verification before dispatching the next Action. Dispatch only the next Action whose prerequisites are satisfied.

## Response Format

Use this structure, omitting sections with no content:

```md
## Current Situation

## Operating Mode

- **Mode:** Chill Mode or Madmax Mode.
- **Recommendation:** recommended mode and the evidence behind it.
- **Selection:** user-selected.

## Selected Principles

1. [Principle] - why it applies now.
2. [Principle] - why it applies now.

## Recommended Action Flow

1. **[Action](../action-name/SKILL.md)** — purpose; input; expected output; transition condition.
2. **[Action](../action-name/SKILL.md)** — purpose; input; expected output; transition condition.

## Next Single Action

- **Action:** [Action](../action-name/SKILL.md) — include the skill link when a matching skill exists; otherwise use the plain action name.
- **Why now:** why this is the first executable step.
- **Mode:** the selected mode and its relevant constraint.
- **Input:** what it needs to start.
- **Code or behavior impact:** intended affected behavior and paths, when relevant.
- **Done when:** the result that hands work to the next flow step.
- **Confirmation:** in Chill Mode, the exact user confirmation required before this Action runs or is dispatched.
- **Sub-agent task:** the bounded dispatched task, including scope and evidence required.

## Chill Explanation

- **What happens now:** plain-language purpose of the current Action.
- **Code or behavior:** the relevant flow, intended change, and affected paths.
- **How it will be judged:** expected evidence and acceptance condition.
- **Progress:** after an Action completes, what changed and why the next Action follows.

## Assumptions and Open Questions
```

The `Next Single Action` section is mandatory. It must contain one and only one concrete Action and its bounded sub-agent task. A skill link is preferred when a matching skill exists, but never fabricate or force a skill; never use `A or B`, a list, or a compound step there.

## Mode Behavior

- **Madmax Mode.** Reach the requested goal through the smallest viable path. Keep the scope narrow, avoid work that does not unblock the goal, and defer non-blocking improvement through Friction. Build Loop and required verification still apply.
- **Chill Mode.** Teach through the work as it proceeds: explain every Action, progress event, code or configuration change, and verification result in plain language. Let the user trace the affected behavior and code flow through linked files and evidence, then obtain explicit confirmation for each single Action before it runs or is dispatched. Understand the target before changing it, investigate causes and boundaries, and address maintainability, edge cases, and verification depth needed for a durable result. Recommend it for bug fixes, reviews, and friction resolution.

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
