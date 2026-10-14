---
name: one-func
description: Implement a complete requested behavior directly inside one function, without decomposing it into helpers, layers, classes, modules, or an architecture design. Use when the user explicitly asks for a single-function implementation, a quick direct implementation, or says to keep all requirements in one function instead of applying clean-code or architecture-oriented decomposition.
---

# One Func

Implement the requested behavior in one function when the user explicitly chooses this constraint. The goal is directness: a reader should be able to inspect one function and find the behavior and decisions that implement the request.

This is an intentional local tradeoff. Do not apply `great-code` or `great-one-code` decomposition rules while this skill is active. Do not redesign the surrounding architecture or extract code to satisfy a preferred style. Keep the result understandable and correct within the one-function constraint.

## Workflow

1. **Bound the function.** Identify the requested inputs, outputs, side effects, required cases, failure behavior, and existing function that best owns the operation. Prefer editing one existing function. If no suitable function exists, add one at the natural entry point.
2. **Keep the behavior together.** Put all newly required domain decisions and control flow directly in that function. Do not add helper functions, nested functions, classes, modules, callbacks that hold business logic, or indirection layers. Do not split the function merely to meet a line-count or style rule.
3. **Use the language and platform directly.** Imports, standard-library calls, framework APIs, and existing dependencies are allowed when they perform a concrete operation. Keep new requirement-specific logic in the chosen function. Reuse an existing external function only for an established capability, not to move part of this feature's behavior out of the function.
4. **Preserve essential behavior.** Implement every stated requirement, including input checks, error paths, cleanup, and observable side effects. The one-function constraint does not justify deleting necessary validation, failure handling, or security checks. Use clear variable names, straightforward branches, and comments only where the reason is otherwise difficult to see.
5. **Make only necessary surrounding edits.** Update the smallest amount of invocation or registration code needed to reach the function. Do not implement part of the requested behavior in another function to make integration convenient. If the request cannot fit one function without changing an unrelated public contract or duplicating behavior, explain the exact conflict and ask which constraint to relax.
6. **Review the constraint.** Inspect the diff and confirm that all newly added behavior resides in the selected function, no helper or architecture layer was introduced, and the function covers each stated case. Run only the checks needed to verify the requested behavior and report any that could not run.

## Completion

Report the function that owns the behavior, the requirements it implements, and the checks performed. If a requirement could not be implemented inside one function, identify it explicitly instead of claiming completion.
