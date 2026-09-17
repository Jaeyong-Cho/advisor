---
name: encode-lessons-in-structure
description: Encode repeated lessons and constraints in code, tooling, metadata, or automated checks.
disable-model-invocation: true
---

# Encode Lessons in Structure

Do not leave recurring corrections and instructions in memory or prose. Enforce them through code, tools, metadata, or automated checks.

## Problem It Solves

Text instructions work only when people read, remember, and follow them. Repeated errors and corrections signal that the current structure permits or invites the error. A structural guard makes the same mistake difficult to repeat and applies the lesson to future work.

## How to Apply It

1. **Identify recurring patterns.** When you write the same instruction twice or the same review finding, test failure, or user correction repeats, determine whether it is a one-off or a rule.
2. **Choose the strongest practical guard.** Consider a model that makes invalid states unrepresentable, a CI lint or banned API, a standard helper, runtime validation, and a script. Choose the smallest guard that reliably prevents the error in the current environment.
3. **Put the rule in the guard.** Express the cause and forbidden result in code, checks, metadata, or automation. Remove redundant instructions once the guard enforces the rule sufficiently.
4. **Leave judgment clear when needed.** Preserve context-dependent judgments that cannot be automated as visible principles and failure examples. Do not repeat vague instructions merely because automation is impossible.
5. **Check the current and next case.** Resolve the current problem and verify that the guard prevents the error for the same input or change. Apply [Build the Lever](../build-the-lever/SKILL.md) when a tool must perform or prove recurring work.

## Stop When

The structural cause of the repeated problem is prevented, or the reason it cannot be automated and a clear human decision rule remain. A recorded lesson is not complete if the next task can make the same mistake.

## Avoid

- Promising not to repeat the error or recording it only in a document.
- Fixing one case while leaving the same pattern possible.
- Building excessive automation for a simple rule.
- Trying to mechanize every judgment and losing necessary human judgment.
