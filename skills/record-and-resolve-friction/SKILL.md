---
name: record-and-resolve-friction
description: Record every deferred friction item and resolve it in Chill Mode.
disable-model-invocation: true
---

# Record and Resolve Friction

In Madmax Mode, skip friction when necessary but record every item immediately. Resolve every recorded item in Chill Mode.

Record and review code smells discovered while understanding code in Chill Mode in the same list.

## Problem It Solves

Problems skipped for speed are forgotten without a record and accumulate unresolved when only recorded. Recording and follow-through are the required agreement between the two modes so that speed gained in Madmax Mode does not become the burden of the next task.

Friction includes deferred errors, design issues, missing validation and error handling, repeated manual work, tool or environment discomfort, and temporary workarounds. Do not exclude an item because it is minor or does not block the immediate goal.

## How to Apply It

1. **Record at the moment of deferral.** Add the item to the task record when you decide to ignore or skip it. Record its location or context, problem, status, and reason for deferral.
2. **Take the full list into Chill Mode.** Treat every recorded item as work. Use priority only to choose order, never to exclude an item.
3. **Decide and act on each item.** For code, first understand it through [Understand Through Abstraction](../understand-through-abstraction/SKILL.md). Confirm the real problem and cause, then improve the needed code, design, tool, or verification. Leave evidence when no action is needed.
4. **Record the result and evidence.** Record what you did and how you checked it, then mark it complete. Verify changes through [Closed Working Loop](../closed-working-loop/SKILL.md). Add newly discovered friction to the same list.

When the same friction or correction repeats, apply [Encode Lessons in Structure](../encode-lessons-in-structure/SKILL.md) to prevent recurrence.

## Stop When

Every item has an outcome and verification evidence. Mark only completed actions or evidence-backed no-action decisions complete. State that the work remains incomplete when deferred, blocked, or future items remain.

## Avoid

- Skipping records for speed or relying only on memory and conversation.
- Treating recording or reading an item as resolving it.
- Moving an item to another list or lowering priority and then marking it complete.
- Claiming there is no problem without evidence or creating an unnecessary change only to mark completion.
