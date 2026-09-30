---
name: flow
description: Explain a specific feature's execution flow from its real entry point to its observable result. Use when the user wants a step-by-step trace of calls, data, state, branches, side effects, and failure paths for one feature or scenario.
---

# Flow

Trace one feature forward from its trigger to its observable outcome. This is a concrete path walkthrough; use [How](../how/SKILL.md) for a broader subsystem mental model. Apply [Understand Through Abstraction](../principle-understand-through-abstraction/SKILL.md) to inspect each function's contract before reading internals, and [Understand Function](../understand-func/SKILL.md) when a specific function's branch or state change needs deeper inspection.

## Steps

1. **Bound the scenario.** Identify the feature, trigger, input or user action, and outcome the user wants explained. If several entry points exist, inspect the routing, registration, event subscription, command wiring, or caller to identify the one for this scenario. State the chosen entry point and mention other relevant entry points without tracing them unless the question requires it.
2. **Follow the execution path.** Start at the confirmed entry point. At each meaningful hop, record the called function or component, the input or state it receives, the decision or transformation it performs, and the output, mutation, or side effect it produces. Follow asynchronous handoffs through queues, events, callbacks, or jobs until the observable result or a documented external boundary. Do not infer that a call runs merely because a function exists.
3. **Account for branches and failures.** Trace the path selected by the user's concrete scenario. For a general feature question, cover the main success path plus materially different early exits and error paths. State the conditions that select each branch and where errors are returned, handled, retried, or exposed. Avoid enumerating every possible combination when it does not change the explanation.
4. **Check evidence and gaps.** Ground each important transition in code, tests, configuration, traces, or logs, with file and symbol locations. Separate a path established by static code from a path observed at runtime. Treat external services, dynamic dispatch, generated code, and unavailable configuration as explicit boundaries until evidence resolves them.
5. **Explain the flow in order.** Present the trigger, entry point, numbered transitions, branch points, side effects, and final outcomes. Show how important values or state change between steps. Use a compact diagram or branch table only when it makes the route easier to follow; link to the decisive source locations instead of pasting a source dump.

## Output

```md
# Feature Flow: <feature and scenario>

## Entry Point

## Main Flow
1. <location and action> -> <resulting state or next step> (evidence)

## Branches and Failures

## Outcome and Evidence Gaps
```

## Done When

The reader can follow the chosen trigger through each meaningful transition to the observable result, predict the important branches and failures, and see which transitions are confirmed versus still opaque. Do not expand into design history, a root-cause diagnosis, or unrelated callers unless the user asks for those questions.
