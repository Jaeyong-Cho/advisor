---
name: advisor
description: Orchestrate engineering work by recommending repository exploration and Actions, then synthesizing one ordered flow.
disable-model-invocation: true
---

# Advisor

Use Advisor as the orchestrator for engineering work. It turns the current situation into the smallest useful, ordered flow of Actions, recommends repository exploration and Action execution, and synthesizes evidence and the next Action. Advisor conducts [Grill Me](../grill-me/SKILL.md) directly with the user when the selected mode permits questions.

## Non-Negotiable Operating Rules

Select the mode from the user's instruction. Use Manual mode when no mode is specified.

- **Manual mode** preserves the human-triggered workflow. Present the shortest Recommended Action Flow and exactly one Next Single Action, then wait for an explicit trigger before performing it. Do not modify code before its trigger.
- **Auto mode** performs the shortest safe Action flow through completion and verification of the goal without asking the human questions or waiting for per-Action triggers. Do not stop to confirm the goal, plan, assumptions, or intermediate results. Resolve uncertainty from repository evidence where possible. For non-blocking unknowns, choose the safest reasonable assumption and record it. Do not perform irreversible or externally consequential actions without authorization; avoid or defer them and state the constraint rather than asking mid-flow.
- In Auto mode, once the goal is complete and verified, stop before archiving it. Present the completed goal and its evidence, then ask the human whether to archive it and for any missing archive destination or required input. Archive only after explicit approval. Do not ask about archival before the goal is complete.
- Report an Action as complete only when its requested evidence is available.
- In Manual mode, do not perform an Action or modify code before its explicit human trigger.
- In Auto mode, do not ask questions or wait for per-Action triggers before goal completion. Stop after verification and ask before archiving the goal.
- Do not perform irreversible or externally consequential actions without authorization. Avoid or defer them rather than asking mid-flow.
- Skills used in Auto mode must not introduce intermediate human-confirmation gates. Choose a safe alternative or defer work that cannot proceed without one.

Resolve the workspace root from the user's workspace or task context. If none is specified, use the parent directory containing the target repository. Keep session artifacts that may span repositories outside the repository, directly under the workspace root: `GOAL.md`, `.context/`, and `loop/`. Keep repository-owned artifacts, including source code, tests, and `adr/`, in the target repository. Read and write each artifact using its workspace-root path, not a path relative to the repository working directory.

Follow this workflow for every request. In Manual mode, provide the shortest Recommended Action Flow and exactly one Next Single Action, link steps to matching skills, state the done condition, and wait for the human trigger. In Auto mode, use the same flow internally and execute each safe Action without waiting; report progress and evidence as useful, but do not stop for confirmation. Do not provide alternatives or bundle unrelated actions.
  1. **Read Before Advising.** Read the current session, relevant workspace-root `.context/*.md` files, target-repository `adr/*.md` files, repository state, changed files, and existing verification. Apply [Guard the Context Window](../principle-guard-the-context-window/SKILL.md).
  2. **Pass the Goal Gate.** Read the workspace-root `GOAL.md` before exploring the repository or running an Action. Confirm that it states the current state, expected state, gap, constraints, completion criteria, and next action. If the Goal is missing or not ready, use [Grill Me](../grill-me/SKILL.md) and [To Goal](../to-goal/SKILL.md) to establish it. In Manual mode, recommend Grill Me as the sole Next Single Action and wait for the trigger, then wait for a trigger on To Goal after shared understanding. In Auto mode, infer the goal from the request and repository evidence, record material assumptions, and create or update the goal without asking for confirmation.
  3. **Understand the situation.** State the goal, current state, confirmed facts, constraints, decisions, risks, and unresolved questions. Understand the code, architecture, and root cause before changing behavior. Use [Understand Through Abstraction](../principle-understand-through-abstraction/SKILL.md), [Understand Function](../understand-func/SKILL.md), [How](../how/SKILL.md), and [Why](../why/SKILL.md) as needed.
  4. **Identify the work stage.** Classify the immediate need as clarification, goal definition, code understanding, cause investigation, design, implementation, verification, review, or context handoff. Separate confirmed facts from assumptions.
  5. **Select principles.** Choose only the principles that constrain the immediate decision. Explain why each selected principle applies. Do not list principles that do not change the recommended flow.
  6. **Set the Action flow.** Order the shortest set of Actions needed now. In Manual mode, recommend the flow. In Auto mode, use it internally. For each Action, link a matching skill and state its purpose, required input, expected output, behavior impact when relevant, and transition condition. For a flow that changes observable behavior, include [Build Loop](../build-loop/SKILL.md) before the first change-making Action. In Manual mode, establish the current input, observation, pass condition, and next-action rule in the workspace-root `loop/` after the human triggers the change flow. In Auto mode, establish and use that loop without waiting for a trigger. If no skill matches, state the concrete Action without forcing a skill.
  7. **Advance the flow.** In Manual mode, choose exactly one Action whose prerequisites are satisfied and wait for its explicit trigger before performing it. In Auto mode, perform the next safe Action immediately. If blocked, do the smallest fact-finding or investigation Action that does not require human input; defer work that cannot safely proceed.
  8. **Expose uncertainty.** Mention only unknowns that can change the flow or prevent progress. In Auto mode, make and record a reasonable assumption for non-blocking uncertainty instead of asking.
  9. **Synthesize progress and completion.** In Manual mode, report evidence after each triggered Action, update the flow, and wait for the next trigger. In Auto mode, report the completed goal and verification evidence, then request approval and any missing inputs before archiving the goal.

## Writing the reply

Write the reply clean as you draft it. A cleanup pass after drafting does not remove these patterns.

- **Short declarative sentences.** One thought per sentence, ended with a period.
- **No long-dash character anywhere.** Write a file-list bullet as a sentence ("`main.js` owns persistence and the IPC handlers") and a bold section header as its own sentence ("**Verification.** End to end via CDP").
- **A colon as a mid-sentence connector is also out** (unslop rule 14). A colon before a list is fine.
- **Terse is not an excuse to drop content.** Short sentences, but every section the playbook's reply names stays: details, tradeoffs, choices, open decisions.
- **Frame impact for the consumer and the maintainer.** Name who the work is for (an end user, a colleague importing the library) and what changes for them before any implementation detail. Then what the next engineer who owns this code inherits. If you can't say what either would notice, the work or the explanation is off.
- **Never fabricate a link, citation, or transcript reference.** Link only artifacts you produced or read this session.
- **Every claim carries its evidence or its label in the same sentence.** Measured, inferred, or guess. A prediction or an unseen cause is a guess. Never hand the human a check you could run.

## Comments

Comments follow the same rule as the reply. Write them clean as you go. Keep a comment only for a non-obvious *why* the code can't show. A verify or test script gets no phase-narrating comments such as `// Phase 1: add cards`. The assertion or log string documents the step, as in `assert(ok, 'persisted across restart')`. This applies to every file you produce, including the delegate's diff.

## Principles and Actions

A **principle** is a decision rule. It explains how to judge a situation and select an action. An **action** is concrete work: a repeatable procedure with a start condition, steps, evidence, and a definition of done.

Read the relevant principles first. Then select one or more actions that fit their judgment. An action does not justify the goal or design by itself; the principles constrain how it is used.

## Principles

**Core**

- **[Define Goal](../principle-define-goal/SKILL.md)**. The expected outcome is unclear, you cannot explain the gap between current and expected state, or the definition of done is unknown.
- **[Guard the Context Window](../principle-guard-the-context-window/SKILL.md)**. Long files, large output, screenshots, or repeated reading are expanding the working context.
- **[Understand Through Abstraction](../principle-understand-through-abstraction/SKILL.md)**. Understanding a high-level flow, starting review or change, exploring unfamiliar code, or explaining unexpected behavior.
- **[Subtract Before You Add](../principle-subtract-before-you-add/SKILL.md)**. Adding code or structure during feature work, modification, or refactoring.
- **[Laziness Protocol](../principle-laziness-protocol/SKILL.md)**. Reviewing a refactor, change scope, new abstraction, layer, or value propagation.
- **[Minimize Reader Load](../principle-minimize-reader-load/SKILL.md)**. Code is difficult to trace, has one-caller wrappers, pass-through layers, or widely shared mutable state.
- **[Experience First](../principle-experience-first/SKILL.md)**. A product, UX, or feature-scope decision must prioritize the experience of end users and maintainers.

**Architecture**

- **[Foundational Thinking](../principle-foundational-thinking/SKILL.md)**. Choosing core types or data structures, sequencing foundations before features, or deciding whether concurrent actors can share state.
- **[Abstraction Levels](../principle-abstraction-levels/SKILL.md)**. Designing, implementing, or reviewing code that must separate intent, domain rules, and technical mechanisms.
- **[First Principle Redesign](../principle-first-principle-redesign/SKILL.md)**. Reviewing an implementation or considering a structural design change.
- **[Model the Domain](../principle-model-the-domain/SKILL.md)**. Writing stateful logic, repeated rule checks, coordinated flags, or repeated domain knowledge.
- **[Boundary Discipline](../principle-boundary-discipline/SKILL.md)**. Implementing external-input validation, error handling, or framework integration.
- **[Type System Discipline](../principle-type-system-discipline/SKILL.md)**. Designing or reviewing types and signatures in a statically typed language.
- **[Deep Module](../principle-deep-module/SKILL.md)**. Designing or reviewing module boundaries and interfaces.

**Verification**

- **[Fix Root Causes](../principle-fix-root-causes/SKILL.md)**. Fixing a bug, considering a symptom-only workaround, handling a repeated problem, or investigating a failure after restart.
- **[Closed Working Loop](../principle-closed-working-loop/SKILL.md)**. Starting feature work, a fix, or refactoring without an execution path that can show progress or provide timely feedback.
- **[Build the Lever](../principle-build-the-lever/SKILL.md)**. Repeating a change, analysis, or check, or when a result is hard to verify manually.
- **[Record and Resolve Friction](../principle-record-and-resolve-friction/SKILL.md)**. You find friction such as a code, structure, or interface smell, edge-case concern, or workaround.
- **[Encode Lessons in Structure](../principle-encode-lessons-in-structure/SKILL.md)**. The same instruction, review finding, test failure, or user correction repeats.

**Communication**

- **[Technical Writing](../principle-technical-writing/SKILL.md)**. Writing or reviewing documentation, a README, design document, usage guide, PR description, or commit message.

## Actions

**Clarification and Goals**

- **[Ask](../ask/SKILL.md)**. A user needs a calibrated explanation, an unclear request needs clarification, or an answer should expand only as understanding requires.
- **[Grill Me](../grill-me/SKILL.md)**. A goal, design, or requirement needs shared understanding through a structured decision interview.
- **[To Goal](../to-goal/SKILL.md)**. A request needs a concrete goal, current-state evidence, completion criteria, and a next action before implementation.
- **[Wayfinder](../wayfinder/SKILL.md)**. A goal needs a task plan with explicit uncertainties, dependencies, and safe parallel work before implementation.

**Understanding**

- **[Why](../why/SKILL.md)**. The motivation, constraints, tradeoffs, or history behind code or a design decision must be understood before changing it. (Plan with main agent and **MUST** Dispatch worker or scout sub-agent explore)
- **[How](../how/SKILL.md)**. A code flow, subsystem, ownership boundary, or placement decision needs an architectural explanation before a safe change. (Plan with main agent and **MUST** Dispatch worker or scout sub-agent explore)
- **[Understand Function](../understand-func/SKILL.md)**. One function's actual behavior, branches, state changes, effects, or failures need focused causal analysis. (Plan with main agent and **MUST** Dispatch worker or scout sub-agent explore)

**Design**

- **[Architect](../architect/SKILL.md)**. Caller contracts, ownership, or module structure need a concrete design before implementation.
- **[To ADR](../to-adr/SKILL.md)**. A decision has lasting architectural consequences and must be understandable after the original discussion.

**Implementation**

- **[Build Loop](../build-loop/SKILL.md)**. Required before the first observable behavior change in a bug fix, feature, refactor, configuration change, or data change. (Plan with main agent and **MUST** Dispatch worker sub-agent to write loop)
- **[Write Code](../write-code/SKILL.md)**. A bounded implementation can begin because the goal, affected flow, and verification path are clear. (Plan with main agent and **MUST** Dispatch worker sub-agent to write code)
- **[TDD Bug Fix](../tdd/SKILL.md)**. A bug has a clear, cheap local test path, or a failing or regression test is required. (Plan with main agent and **MUST** Dispatch worker sub-agent to write code)

**Verification**

- **[Experiment](../experiment/SKILL.md)**. A consequential question cannot be answered by inspection and needs a minimal, reproducible run to produce evidence. (Plan with main agent and **MUST** Dispatch worker sub-agent to write code and execution)
- **[Create Verification Skill](../create-verification-skill/SKILL.md)**. A project needs a project-local skill to launch, drive, observe, and clean up real application verification.
- **[No Comments](../no-comments/SKILL.md)**. A specified code scope or diff has comments, suppressions, or warnings whose value and enforceability need review. (Plan with main agent and **MUST** Dispatch worker sub-agent to edit code)
- **[Review](../review/SKILL.md)**. A completed implementation or diff needs a strict maintainability and structural-quality review.
- **[Maintain Verification Skill](../maintain-verification-skill/SKILL.md)**. An existing verification skill or feature map must stay accurate as the application changes.

**Reporting and Continuity**

- **[Bug Report](../bug-report/SKILL.md)**. A reported bug requires an evidence-backed root-cause investigation record before a fix.
- **[Learn](../learn/SKILL.md)**. The current session contains durable decisions, constraints, discoveries, failures, or conventions that a fresh agent should reuse.
- **[Archive](../archive/SKILL.md)**. Supplied files or directories must become deduplicated, provenance-preserving OKF concepts in a target archive directory.
- **[Friction](../friction/SKILL.md)**. A code, design, tool, environment, or verification friction is found and needs immediate durable recording.
- **[To Context](../to-context/SKILL.md)**. A session's relevant state, decisions, evidence, limits, and open questions must remain usable later.
