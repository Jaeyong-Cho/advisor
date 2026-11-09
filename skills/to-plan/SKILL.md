---
name: to-plan
description: Write decisions from plan-mode to a standalone Markdown execution plan another agent can follow. Use when the user asks to save or hand off an agreed plan.
---

# To Plan

Turn the decisions from [Plan Mode](../plan-mode/SKILL.md) into an execution handoff for an agent with limited context and no access to the planning conversation.

## Write the handoff

1. Use the latest plan and subsequent user corrections. Preserve the agreed outcome, scope, and approach. If an unresolved decision could change the outcome or scope, record it as a blocker with the input needed to proceed.
2. Write to the path the user specifies or to `PLAN.md` at the workspace root. Update an existing plan for the same task. If the default file belongs to a different task, preserve it and use a task-specific Markdown filename.
3. Put steps in dependency order. For each step, state the action, relevant file or entry point when known, and expected result. Include known commands with their working directory when it matters. If a fact must be checked first, say what to inspect and how the result affects the next step.
4. State how to verify the outcome and when to stop and report a blocker. Flag discrepancies that invalidate an agreed decision. Check that the document makes sense without chat references or unstated prerequisites.

## Document structure

- **Goal and done criteria** — the observable result and how to recognize it.
- **Starting point and decisions** — relevant evidence, prerequisites, and the chosen approach.
- **Scope and constraints** — what to change, what behavior to preserve, and any required approvals.
- **Execution steps** — ordered actions with expected results and any conditions for proceeding.
- **Verification** — checks or commands and the expected outcomes.
- **Open decisions or blockers** — include this section when execution depends on them.

Report the written file path and any blockers. This skill ends after writing and checking the handoff. Execution starts when the user authorizes it.
