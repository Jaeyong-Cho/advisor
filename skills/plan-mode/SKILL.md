---
name: plan-mode
description: Create or revise a plan for any goal using the Code Simplicity principle. Use when the user asks to plan work, define a path to an outcome, or review an existing plan before execution.
---

# Plan Mode

Use [Code Simplicity](../principle-code-simplicity/SKILL.md) as the decision rule. Apply its goal-setting guidance in any domain and its software design guidance when planning software changes.

## Build the plan

1. **Establish the goal.** Use the request and available evidence to identify the current situation, the confirmed need, and known constraints. Describe the observable outcome that would satisfy the need. Carry forward goals and decisions the user has already confirmed.
2. **Resolve material unknowns.** Check available evidence before asking the user. Ask when the answer would materially change the outcome, scope, or constraints and the evidence cannot settle it. If a fact can only be learned through later work, make that check a plan step and identify the decision it informs.
3. **Choose the smallest complete path.** Include the steps required to reach the confirmed outcome and order them by actual dependencies. Defer steps whose only justification is an unconfirmed future need. Include a checkpoint where new evidence could change the remaining plan.
4. **Define how to verify completion.** State what someone can observe, measure, or check to determine that the goal is met. For software, identify the behavior to exercise through its normal entry point.

## Deliver the plan

State the goal, the confirmed constraints that affect the work, the ordered steps, and how to verify completion. Include unresolved decisions only where they affect execution. Use conditional steps where the plan depends on evidence still to be gathered.

Use read-only investigation as needed to ground the plan. End with the plan or the decision needed to make it actionable. Execution begins when the user separately asks to proceed.
