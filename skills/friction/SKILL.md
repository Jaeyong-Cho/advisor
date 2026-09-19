---
name: friction
description: Evaluate a potential engineering friction against relevant principles, then record it in the backlog only after user confirmation.
disable-model-invocation: true
---

# Friction

Evaluate a potential friction before recording it. Use the relevant principles to decide whether it is a real obstacle to the work, then ask the user to confirm it belongs in the backlog.

## When to Use

Use this skill when you notice a possible code smell, design concern, missing validation, edge case, repeated manual step, unreliable tool or environment behavior, workaround, confusing interface, or other obstacle that you do not intend to resolve immediately.

## Steps

1. Gather concrete evidence for the candidate: its location or situation, observed behavior, impact, and the work it makes harder.
2. Select the principles that apply and judge the candidate against them. For example:
   - Use [Understand Through Abstraction](../principle-understand-through-abstraction/SKILL.md) before calling unfamiliar code a smell.
   - Use [Fix Root Causes](../principle-fix-root-causes/SKILL.md) when a workaround hides a causal problem.
   - Use [Closed Working Loop](../principle-closed-working-loop/SKILL.md) when missing feedback or verification blocks confidence.
   - Use [Minimize Reader Load](../principle-minimize-reader-load/SKILL.md), [Deep Module](../principle-deep-module/SKILL.md), or [Boundary Discipline](../principle-boundary-discipline/SKILL.md) for structure and interface concerns.
   - Use [Build the Lever](../principle-build-the-lever/SKILL.md) for repeated manual work.
3. Propose the candidate to the user. State the evidence, the principle-based judgment, the impact, and the smallest next Chill Mode action. Ask whether to add it to `FRICTION.md`.
4. Append an entry to the end of `FRICTION.md` at the repository root only after the user confirms. Do not reorder entries or rewrite an entry unrelated to the current work.
5. State the current disposition: `open`, `deferred`, `blocked`, `not-actionable`, or `done`. Record why an item is deferred, blocked, or not actionable.
6. Keep appending newly confirmed friction to the same file. When an item is completed, retain it: change its heading and disposition to `done`, and add the outcome and verification evidence to that same entry. Do not delete completed friction.

## Proposal Format

Present the candidate before writing it:

```md
## Potential Friction: <short title>

- **Observed in:** <path, symbol, command, or situation>
- **Evidence:** <observed behavior, error, reproduction, or reference>
- **Principle-based judgment:** <relevant principle and why this is friction>
- **Impact:** <risk or cost if left unresolved>
- **Next Chill action:** <smallest investigation or action>

Add this item to `FRICTION.md`?
```

## Backlog Entry Format

Append only after confirmation:

```md
## [open] <short title>

- **Observed in:** <path, symbol, command, or situation>
- **Friction:** <what makes work, understanding, or verification harder>
- **Impact:** <risk or cost if left unresolved>
- **Evidence:** <observed behavior, error, reproduction, or reference>
- **Next Chill action:** <smallest investigation or action>
- **Disposition:** <open, deferred, blocked, not-actionable, or done>
- **Outcome and verification:** <required when disposition is done>
```

## Done When

The candidate has a principle-based judgment and the user has either confirmed it for `FRICTION.md` or declined to record it. A completed item remains in `FRICTION.md` with disposition `done`, its outcome, and its verification evidence.

## Avoid

- Recording a vague complaint without a location, situation, evidence, or applicable principle.
- Calling unfamiliar code a smell before understanding its responsibility and constraints.
- Treating a workaround as proof of the underlying problem without investigating it.
- Appending an item without user confirmation.
- Deleting completed friction instead of marking it `done` with its outcome and verification evidence.
