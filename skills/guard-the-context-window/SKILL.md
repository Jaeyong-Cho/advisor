---
name: guard-the-context-window
description: Keep working context focused on evidence needed for the current decision.
disable-model-invocation: true
---

# Guard the Context Window

Keep only information needed for the current decision in the working context. Isolate large source material and bring back only the evidence and summary that matter.

## Problem It Solves

Working context is finite. Reading long files, logs, command output, screenshots, and documents without a purpose buries key requirements and earlier decisions. That leads to rereading the same material, making changes that conflict with earlier decisions, and forgetting important verification conditions.

## How to Apply It

1. **Set the question before reading.** Define the decision you need to make and the information it requires. Do not load the entire repository, long logs, or large documents without a question.
2. **Isolate large material.** Inspect long files, build logs, test output, screenshots, and generated results selectively. Record relevant paths, locations, observations, and evidence instead of carrying the full source forward.
3. **Work in bounded phases.** Finish investigation and change for one question or area at a time. Carry forward only conclusions and unresolved items needed by the next phase. Do not reread source material for an answered question.
4. **Preserve a compact current state.** Keep the goal, constraints, decisions, confirmed facts, and verification state in a short work record. Record where source evidence can be found and what conclusion it supports instead of copying it.
5. **Treat output as a cost.** Configure tools and checks to show only necessary output. Turn recurring verification into a rerunnable tool with [Build the Lever](../build-the-lever/SKILL.md). When several investigation paths are needed, use only their conclusions and evidence for the next decision.

## Stop When

You have evidence for the current decision and verification, can briefly explain the goal, constraints, decisions, and unresolved items, and additional source material is unlikely to change the decision. Reopen only the material required by a new question.

## Avoid

- Reading long files, full logs, or the entire repository without a question.
- Passing large output and raw source material unchanged to the next work phase.
- Leaving a summary without an evidence location or a way to verify it.
- Starting new exploration after losing the established goal and constraints.
- Investigating too many areas in one phase to separate conclusions from unresolved items.
