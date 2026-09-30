---
name: architect
description: Explore architecture alternatives through subagents, then compare their pros and cons and present a recommendation when a system's structure is uncertain.
disable-model-invocation: true
---

# Architect

Help the user choose an architecture. Subagents develop distinct proposals and explain their pros and cons. The main agent owns the comparison, synthesis, and recommendation presented to the user.

This skill produces a design comparison. Implement only when the user also requests implementation.

## Steps

1. **Frame the decision.** Establish the goal, current architecture, constraints, and criteria for comparing options. Use [How](../how/SKILL.md) to trace affected systems and [Why](../why/SKILL.md) when changing existing ownership. Read the relevant principles first, such as [Deep Module](../principle-deep-module/SKILL.md), [Model the Domain](../principle-model-the-domain/SKILL.md), and [Type System Discipline](../principle-type-system-discipline/SKILL.md).
2. **Delegate alternative designs.** Spawn multiple subagents with the same goal, constraints, relevant evidence, and comparison criteria. Give each a different design direction or responsibility for exploring a distinct approach. Let each subagent develop its proposal independently before seeing the others. Include reuse of the existing architecture when viable. Subagents inspect and propose; they do not modify shared files or implement their designs. If subagent tools are unavailable, disclose the limitation and compare alternatives directly without claiming independent proposals.
3. **Collect comparable proposals.** Ask each subagent for the architecture's core idea, caller example or flow, responsibilities and ownership, contracts and state transitions where relevant, pros, cons, risks, assumptions, and verification criteria. Include migration effort when changing an existing system. Tie benefits and costs to the shared goal and constraints.
4. **Compare as the main agent.** Wait for the proposals, check consequential claims against available evidence, and resolve conflicting assumptions. Merge equivalent ideas and exclude designs that violate hard constraints, explaining why. Evaluate the remaining options against the same criteria. Distinguish facts from estimates and assumptions. Request a focused follow-up from a subagent when a gap could change the ranking.
5. **Synthesize for the user.** Present the distinct options and their pros and cons in a compact comparison. Recommend the best fit for the user's goal, explain the decisive trade-off, and state when another option would be preferable. A combined design is appropriate only when its parts fit together and its added complexity is justified. End with the next decision or smallest useful verification step.

## Output

Scale detail to the decision. Provide:

- The goal, constraints, and comparison criteria.
- A short sketch of each viable architecture, including its main flow and ownership boundaries.
- A comparison table covering pros, cons, risks or effort, and when each option fits best.
- The main agent's recommendation, decisive trade-off, unresolved assumptions, and next step.

Integrate the proposals into one explanation rather than forwarding subagent reports verbatim.

## Done When

The user can compare distinct architecture proposals, understand their pros and cons, and see why the main agent recommends one and what could change that recommendation.

## Avoid

- Producing several cosmetic variations of the same architecture.
- Comparing proposals that rely on different unstated requirements.
- Treating subagent agreement or confidence as evidence.
- Adding speculative layers or treating every local edge case as a reason to redesign.
- Starting implementation from a design-only request.
