---
name: execute-plan
description: Execute a Markdown plan written by to-plan and record verified results. Use when the user asks to run PLAN.md or another named plan, including when the planning conversation is unavailable.
---

# Execute Plan

Use the Markdown handoff from [To Plan](../to-plan/SKILL.md) as the task brief. Work from the plan and the current workspace.

## Read and execute

1. Open the plan the user names, or `PLAN.md` at the workspace root. Read it in full and identify the goal, constraints, prerequisites, ordered steps, expected results, and completion checks. If the file is missing or an essential decision is unspecified, report what is needed. Follow applicable workspace instructions and approval requirements.
2. Check the starting state against the plan. Read any existing results file and verify completed work against the current state before skipping or repeating a step. Preserve existing user changes. If a mismatch affects the agreed scope, outcome, or safety of a step, record the evidence and stop the affected work. Continue independent steps only if they remain valid and useful.
3. Execute the authorized steps in dependency order. For a conditional step, gather the specified evidence before choosing a branch. Check each expected result before running work that depends on it. Resolve routine execution issues within the plan's constraints. If a prerequisite, approval, or material decision is missing, record which steps are blocked and what would unblock them.
4. Run the plan's verification checks against the resulting state. Record the command or check, its working directory when relevant, the expected result, and the actual result. Mark checks that could not run as skipped with the reason. Mark the plan complete only when all required steps and completion criteria are verified.

## Record results

Write a sibling Markdown file named `<plan-stem>-RESULTS.md`, such as `PLAN-RESULTS.md` for `PLAN.md`. Keep the plan as the agreed brief and update the results after each completed step or blocker so another agent can resume.

Include:

- **Plan and status** — the plan path and whether execution is in progress, complete, or incomplete.
- **Execution** — the step, action taken, affected files or artifacts, and observed result.
- **Verification** — each check, expected and actual results, and whether it passed, failed, or was skipped.
- **Remaining work** — unfinished steps, blockers, and the input or action needed to proceed.

Finish by reporting the results file path, completion status, and any failed or skipped required checks.
