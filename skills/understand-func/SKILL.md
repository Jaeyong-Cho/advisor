---
name: understand-func
description: Explain one function's causal behavior from inputs and state through branches, effects, failures, and outputs.
disable-model-invocation: true
---

# Understand Function

Understand one function deeply enough to predict its observable behavior without turning a wider code investigation into a line-by-line source dump.

## When to Use

Use this action when a concrete function's contract does not answer the current question, or when review or root-cause work requires its actual behavior. Provide a file path, function symbol, and the behavior to explain.

[Understand Through Abstraction](../understand-through-abstraction/SKILL.md) owns choosing which function to inspect and how far to descend through dependencies. [How](../how/SKILL.md) owns subsystem-level explanations.

## Steps

1. **Bound the target.** State the path, symbol, question, and relevant caller or entry point. If the symbol is ambiguous or unavailable, report that fact instead of guessing.
2. **State the external contract.** Identify inputs, caller expectations, outputs, errors, and externally observable side effects. Keep the body unread when this already answers the question.
3. **Trace execution in order.** Read the function body from start to finish. Record each meaningful validation, branch, transformation, state mutation, external call, return, and throw as **condition -> action -> observable effect**.
4. **Account for input and state categories.** Explain how relevant inputs and prior state select different branches and terminal outcomes. Distinguish local state from state changed outside the function.
5. **Bound dependencies.** Use a called function's contract when it answers the needed fact. Descend only when that fact remains unknown; do not follow dependencies merely because the target calls them.
6. **State evidence and gaps.** Separate confirmed behavior from opaque runtime, generated, dynamic, or external behavior that the available code cannot establish.

## Output

```md
# Understand Function: <path>#<symbol>

## Scope

## Contract

## Execution Trace

## Observable Outcomes

## Dependencies and Gaps
```

Use a compact branch table when it makes input or state-dependent outcomes clearer. Do not paste the full source unless a small excerpt is essential evidence.

## Done When

A reader can predict the function's outputs, errors, state changes, and external effects for every relevant input and state category without reading its body.

## Avoid

- Inferring behavior from a function name or signature alone.
- Following every callee instead of answering the current function question.
- Treating an external call as understood when its behavior is not evidenced.
- Listing lines without explaining their causal effect.
- Expanding a one-function investigation into a subsystem walkthrough.
