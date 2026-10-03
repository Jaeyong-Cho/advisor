---
name: flow
description: Explain a specific feature's execution flow from its real entry point to its observable result with an execution tree and component relationship diagram. Use when the user wants a trace of calls, data, state, branches, side effects, and failure paths for one feature or scenario.
disable-model-invocation: true
---

# Flow

Trace one feature forward from its trigger to its observable outcome. This is a concrete path walkthrough; use [How](../how/SKILL.md) for a broader subsystem mental model. Apply [Understand Through Abstraction](../principle-understand-through-abstraction/SKILL.md) to inspect each function's contract before reading internals, and [Understand Function](../understand-func/SKILL.md) when a specific function's branch or state change needs deeper inspection.

## Steps

1. **Bound the scenario.** Identify the feature, trigger, input or user action, and outcome the user wants explained. If several entry points exist, inspect the routing, registration, event subscription, command wiring, or caller to identify the one for this scenario. State the chosen entry point and mention other relevant entry points without tracing them unless the question requires it.
2. **Follow the execution path.** Start at the confirmed entry point. At each meaningful hop, record the called function or component, the input or state it receives, the decision or transformation it performs, and the output, mutation, or side effect it produces. Follow asynchronous handoffs through queues, events, callbacks, or jobs until the observable result or a documented external boundary. Do not infer that a call runs merely because a function exists.
3. **Account for branches and failures.** Trace the path selected by the user's concrete scenario. For a general feature question, cover the main success path plus materially different early exits and error paths. State the conditions that select each branch and where errors are returned, handled, retried, or exposed. Avoid enumerating every possible combination when it does not change the explanation.
4. **Check evidence and gaps.** Ground each important transition in code, tests, configuration, traces, or logs, with file and symbol locations. Separate a path established by static code from a path observed at runtime. Treat external services, dynamic dispatch, generated code, and unavailable configuration as explicit boundaries until evidence resolves them.
5. **Show the flow and its owners.** Briefly state the scenario and confirmed entry point, then show the execution tree near the top. Follow it with a component relationship diagram using the same owners and symbols. Explain important inputs, state changes, side effects, branches, and outcomes outside the diagrams. Link owners and decisive transitions to source locations instead of pasting a source dump.

## Output

Always include both diagrams directly in the response inside fenced `text` blocks. Scale the supporting prose to the scenario. Both diagrams describe the existing implementation; do not introduce proposed components or reshape control flow into a preferred design.

````md
# Feature Flow: <feature and scenario>

## Entry Point

## Execution Tree
```text
<entry-point function and actual control flow>
```

## Component Relationships
```text
<existing owners and labeled relationships>
```

## Flow Details
<important inputs, state changes, side effects, and source links>

## Branches and Failures

## Outcome and Evidence Gaps
````

### Execution Tree

- Use connected tree characters (`├──`, `└──`, `│`) and consistent indentation, following the presentation used by [Design](../design/SKILL.md).
- Start with the confirmed entry-point function. Show its direct calls as siblings in execution order. Sequential calls do not become children of the previous call.
- Nest only for actual control flow or an expanded callee's own calls. Preserve the implementation's nesting, early returns, and failure handling; do not rewrite it for the explanation. Keep each view at a consistent abstraction level.
- Express conditions and repetition as code-like `if condition`, `else if condition`, `else`, and `for item in items`, or the equivalent construct used by the source. Show terminal outcomes with `return` or `throw` where applicable. Do not use operation numbers, branch labels such as `[valid]`, or markers such as `[END]`.
- Use real owner-qualified function names where applicable and short code-like statements. Put argument details, contracts, evidence links, and explanations outside the tree. Keep lines within roughly 80 columns.
- Show a loop body once. Show a shared continuation once after the branches that reach it. Represent asynchronous handoffs with their actual calls; show a separately rooted continuation tree and explain the event, callback, or job that connects them without implying a synchronous call.
- Expand a callee in a separate tree rooted at that function when inline expansion would make the overview deep or repetitive. Use the same function name in both trees, without reference labels.
- For a concrete scenario, identify the selected branches in the accompanying prose. Mark unresolved dynamic calls or external continuations as evidence gaps rather than inventing a path.

Illustrative shape; replace names and conditions with the implementation's actual symbols:

```text
RequestHandler.handle(request)
├── input = RequestHandler.parse(request)
├── if input.isInvalid
│   └── return RequestHandler.rejectedResponse(input.error)
├── result = FeatureService.execute(input.value)
└── return RequestHandler.response(result)

FeatureService.execute(input)
├── decision = DomainModel.decide(input)
├── if decision.isRejected
│   └── return decision.rejection
├── saved = Repository.save(decision)
└── return saved
```

### Component Relationships

Use a separate ASCII diagram for the files, classes, or modules participating in the traced scenario. Identify what the nodes represent and map each owner to its real path and symbols with source links outside the diagram.

Label arrows with the evidenced relationship, such as `calls`, `uses`, `owns`, `implements`, or `publishes` / `consumes`. Distinguish runtime call direction from type dependency direction when they differ. Include relevant external boundaries and asynchronous connections; mark unresolved relationships explicitly. Execution order alone does not establish a dependency or ownership relationship.

For example, if the source establishes these class relationships:

```text
[RequestHandler] --calls--> [FeatureService] --calls--> [DomainModel]
                                  |
                                uses
                                  v
                            [Repository]
                                  ^
                             implements
                                  |
                           [DatabaseAdapter]
```

## Done When

The reader can follow the chosen trigger through each meaningful transition to the observable result, predict the important branches and failures, and see which transitions are confirmed versus still opaque. The execution tree and component relationship diagram are both present, use consistent owners and symbols, and agree with the source and accompanying explanation. Do not expand into architecture proposals, design history, a root-cause diagnosis, or unrelated callers unless the user asks for those questions.
