---
name: principle-fix-root-causes
description: Fix the causal source of a bug rather than hiding its visible symptom.
disable-model-invocation: true
---

# Fix Root Causes

When fixing a bug, find and correct the root cause instead of hiding the symptom.

## Problem It Solves

A guard, default value, or ignored exception can hide a current error while leaving the incorrect state or rule intact. Such workarounds make the next failure harder to explain and allow the same problem to recur.

## How to Apply It

1. **Reproduce first.** Confirm the input, state, execution order, and actual result that produce the symptom. If you cannot reproduce it, record what remains unobserved and create a way to judge whether the fix works.
2. **Trace from symptom to cause.** Follow [Understand Through Abstraction](../principle-understand-through-abstraction/SKILL.md): begin at the entry function, inspect responsibilities and contracts, and read only necessary functions line by line. Ask why each state or result occurs.
3. **Explain the root cause.** Connect the condition that produces the symptom, the code, state, or contract violation that created it, and why existing validation did not prevent it. Do not confirm a cause from speculation alone.
4. **Fix the cause.** Correct the responsible boundary, state transition, data validation, or domain rule. A nil check, catch-all exception handler, or default that only hides the symptom is not a root-cause fix.
5. **Inspect the same pattern.** Check whether the same cause exists in other paths or matching code. Change only the scope where the same condition holds.
6. **Instrument when blocked.** Observe logs, error values, state, and execution paths to test the hypothesis. For bugs that occur only after restart, inspect persisted configuration, cache, locks, and serialized values first.
7. **Verify through the reproduction path.** Use [Closed Working Loop](../principle-closed-working-loop/SKILL.md) to check the same condition that produced the pre-fix symptom. If a clear, cheap local test path exists, run [TDD Bug Fix](../tdd/SKILL.md) before changing production code.

## Stop When

The reproduced symptom disappears after the root-cause fix, and you can explain the causal link and why the change removes it. Record whether you inspected other paths to which the same cause could apply.

## Avoid

- Fixing a symptom from a guess without reproduction or observation.
- Treating an error-suppressing guard or ignored exception as a root-cause fix.
- Fixing one case without checking other paths with the same cause.
- Repeating the same hypothesis without instrumentation when analysis is blocked.
