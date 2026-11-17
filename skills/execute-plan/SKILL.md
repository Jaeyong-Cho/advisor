---
name: execute-plan
description: Execute a Markdown plan and report completed tasks and verification results in the current conversation. Use when the user asks to run PLAN.md or another named plan.
---

# Execute Plan

Use the Markdown plan as the task brief. Work from the plan and the current workspace.

## Read and execute

1. Open the plan the user names, or `PLAN.md` at the workspace root. Read it in full and identify the goal, constraints, prerequisites, ordered steps, expected results, and completion checks. If the file is missing or an essential decision is unspecified, report what is needed. Follow applicable workspace instructions and approval requirements.
2. Check the starting state against the plan. Verify any previously completed work against the current state before skipping or repeating a step. Preserve existing user changes. If a mismatch affects the agreed scope, outcome, or safety of a step, capture the evidence for your reply and stop the affected work. Continue independent steps only if they remain valid and useful.
3. Execute the authorized steps in dependency order. For a conditional step, gather the specified evidence before choosing a branch. Check each expected result before running work that depends on it. Resolve routine execution issues within the plan's constraints. If a prerequisite, approval, or material decision is missing, record which steps are blocked and what would unblock them.
4. Run the plan's verification checks against the resulting state. Record the command or check, its working directory when relevant, the expected result, and the actual result. Mark checks that could not run as skipped with the reason. Mark the plan complete only when all required steps and completion criteria are verified.

## Report results in the conversation

Use the final reply as the execution report. Create a separate results file only if the user explicitly requests one.

Include:

- **Plan and status** — the plan path and whether execution is complete or incomplete.
- **Execution** — the step, action taken, affected files or artifacts, and observed result.
- **Verification** — each check, expected and actual results, and whether it passed, failed, or was skipped.
- **Remaining work** — unfinished steps, blockers, and the input or action needed to proceed.
