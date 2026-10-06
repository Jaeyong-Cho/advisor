---
name: design
description: First explain a feature's behavior in plain language and establish shared understanding, then interpret that explanation into architecture, domain models, an execution tree, and ASCII relationships without implementation.
disable-model-invocation: true
---

# Design

Explain how a feature works from its entry point, then derive its architecture from that explanation. Actions reveal execution flow, nouns suggest domain concepts, and relationships and constraints guide data structures. Subjects identify who owns the work; events reveal state changes. Design the code so its orchestration can read in the same order as the explanation.

Default to a small, complete change. Define the minimum scope that achieves the required behavior first, then apply abstraction, modeling, and other design principles inside that scope.

Work in two stages: **explain the behavior -> establish shared understanding -> interpret it into architecture**. Present the explanation before proposing files, classes, functions, or data structures. Let the user correct the behavior before structural choices become the premise.

Present the design only in the conversation. Do not write or modify files, save design artifacts, implement, create executable scaffolding, or run the proposed flow. Inspect existing code when needed; distinguish proposed behavior from observed behavior in the explanation.

## Set the Smallest Complete Scope First

- **YAGNI:** Design for confirmed current requirements. Exclude speculative features, extension points, configuration, and infrastructure for possible future needs.
- **KISS:** Prefer the simplest understandable structure that satisfies the behavior and constraints. Reuse existing owners and representations when they fit. Minimize new concepts, dependencies, and coordination rather than merely counting changed lines.
- **[Ponytail](https://github.com/DietrichGebert/ponytail/blob/main/skills/ponytail/SKILL.md):** Understand the affected flow, then check necessity, existing code, standard-library features, native platform capabilities, and installed dependencies before proposing custom structure. Stop at the first option that meets the requirements; otherwise propose the minimum new logic. Preserve readability and required validation, failure handling, and behavior.
- **Bound the change:** State the current-to-expected behavior gap, the operations and contracts that must change, what must be preserved, and the observable completion criteria. Include only changes necessary to close that gap; keep unrelated cleanup and broader redesign outside this increment.
- **Apply design principles locally:** Use abstraction levels, cohesive modules with narrow interfaces, domain models, and types to clarify the selected change. Introduce a boundary or representation only when it owns a required rule, prevents an actual invalid state, hides necessary complexity, or reduces caller burden. A principle is not a reason to restructure unaffected code.
- **Expand only for demonstrated necessity:** Inspect adjacent callers and shared state to understand the impact. Widen the proposed scope when the smaller design cannot satisfy a required behavior, invariant, or contract, and explain the concrete reason. A small change must still be complete and correct.

For example, adding an optional sort order to an existing list operation may require a parameter, boundary validation, and query ordering. It does not by itself require a sorting strategy hierarchy or a redesign of the repository. Apply abstraction and modeling to the changed operation and its necessary boundaries.

## Derive Architecture from the Explanation

Write each meaningful step as **subject -> action -> outcome**, including the input or condition when needed. Make the subject explicit rather than hiding responsibility in passive descriptions.

Use the following mapping during the architecture stage, after the explanation is understood:

| Element in the explanation | Design element |
| --- | --- |
| Subject responsible for work | File or class that owns the responsibility |
| Action performed by a subject | Function owned by that file or class |
| Noun naming a domain concept | Entity, value object, primitive value, or external actor |
| "Has" or "belongs to" | Relationship, cardinality, composition, or ownership to investigate |
| "Same" or "unique" | Identity and uniqueness; candidate key, set, or map |
| "At most", "at least", or "must" | Constraint or invariant that valid states must satisfy |
| "Only when" | Precondition for an operation or transition |
| "Was created", "completed", or "cancelled" | Event indicating a state change |
| "Can" | Capability or behavior that needs a responsible owner |
| Order of actions and branch conditions | Execution flow from the entry point |
| Interaction between subjects | Call, dependency, or ownership relationship |

These are candidates to refine with the principles below. A data object or external actor mentioned in the explanation is not automatically a new class. Repeated subjects can share an existing owner, and related actions can belong to one deep module. Keep each proposed file, class, and function traceable to the behavior it supports.

**Keep interfaces narrow and few.** Expose only the public operations, parameters, and options callers need. Each operation should complete meaningful work and provide substantial value while keeping related rules, state, and mechanisms inside a cohesive module. Keep internal steps private so callers do not have to assemble the behavior or coordinate intermediate state. At representative call sites, check that the contract reduces required knowledge and coordination. Preserve explicit failure conditions and side effects; shrinking the interface must not conceal required behavior or combine unrelated responsibilities.

## Derive Models and Data Structures

Refine the explanation through **concepts -> relationships -> constraints -> behavior -> representation**. Use the execution walkthrough to discover requirements, then establish the model before refining function signatures.

- **Distinguish concepts from behavior owners.** An actor in a requirement may remain external to the system. Choose an entity when identity matters across changes, a value object when value semantics and domain rules justify it, or a primitive when it sufficiently represents the concept. A noun alone does not justify a class.
- **Ask what must always remain true.** Record each invariant, the requirement it comes from, its owner, and the operations that could violate it. Distinguish persistent invariants from operation preconditions and boundary input validation. Mark inferred rules as assumptions rather than adding them to the requirements.
- **Choose structures from relationships and access patterns.** Examine identity, uniqueness, cardinality, ordering, lookup, and mutation. State which valid states must be represented and which invalid states must be prevented. Prefer types and structures that enforce a rule directly; assign runtime checks for rules they cannot enforce.
- **Keep consistency under an owner.** Collect related state and mutations where the same invariants can be protected. Consider an aggregate boundary when several concepts must change consistently, but do not introduce an aggregate framework or transaction merely because concepts are related. Address concurrent mutation when the feature requires it.
- **Use events to discover lifecycle.** Identify the state before an event, the state after it, the permitted transition, its preconditions, and the operation that owns it. An event is evidence of a meaningful change; it does not by itself require an event class, message broker, event sourcing, or asynchronous execution.

For example, "adding the same product increases its quantity" suggests one CartItem per ProductId and lookup by that identity. A candidate `items: map[ProductId, CartItem]` supports that relationship. The map does not enforce "at most 20 distinct products": Cart.add must reject a new key when 20 keys already exist while still allowing an existing item's quantity to increase. The model and execution branches must express both cases. Quantity can remain an integer unless its rules justify a separate value type.

## Principles

Set scope using the rules above before choosing structure. Read the principles relevant to that scope and name the rules that explain consequential choices. Read their supporting references only when needed.

- [Define Goal](../principle-define-goal/SKILL.md): make the current-to-expected gap and completion criteria explicit before setting the change boundary.
- [Incremental Progress](../principle-incremental-progress/SKILL.md): select one small, complete improvement aligned with the goal; define how to observe its effect before choosing later changes.
- [Subtract Before You Add](../principle-subtract-before-you-add/SKILL.md): within the selected scope, identify existing responsibilities to reuse, merge, or remove before proposing new structure.
- [Laziness Protocol](../principle-laziness-protocol/SKILL.md): choose the smallest maintainable solution that meets the goal without omitting required behavior.
- [Abstraction Levels](../principle-abstraction-levels/SKILL.md): keep orchestration at the level of intent, domain decisions separate, and technical mechanisms behind meaningful operations.
- [Deep Module](../principle-deep-module/SKILL.md): expose few meaningful operations through narrow interfaces that provide substantial value. Keep related complexity inside cohesive modules and reduce caller knowledge and coordination.
- [Boundary Discipline](../principle-boundary-discipline/SKILL.md): validate and convert external inputs at entry boundaries, and assign responsibility for translating failures at exit boundaries.
- [First Principle Redesign](../principle-first-principle-redesign/SKILL.md): derive the selected change from purpose and required outcomes; reconsider existing structure within that scope without assuming a full redesign is needed.
- [Foundational Thinking](../principle-foundational-thinking/SKILL.md): establish core data shapes and ownership before detailing operations; identify shared state when concurrency matters.
- [Model the Domain](../principle-model-the-domain/SKILL.md): express states and transitions explicitly, and keep the same domain knowledge together even when it is used at different execution stages.
- [Type System Discipline](../principle-type-system-discipline/SKILL.md): in statically typed systems, make inputs, outcomes, and branch cases explicit in types without unsafe escapes.

## Workflow

### Stage 1: Explain the Feature

1. **Establish the behavior and scope.** State its purpose, trigger, starting point, inputs, observable outcomes, and constraints in the user's domain language. Inspect the relevant current flow and distinguish requirements from implementation accidents. Define the smallest complete scope using the rules above, including behavior to preserve and work outside this increment. Ask only for missing information that could materially change the behavior or scope.
2. **Explain what happens.** Describe the main successful path in subject-action-outcome sentences. Say who does what, what information is needed, and what changes as a result. Use ordinary domain terms rather than proposed code symbols, type definitions, or layers.
3. **Explain the alternatives and rules.** Describe the major conditions, alternate outcomes, constraints, and state changes as part of the story. Include consequential failure paths. Explain required repetition or concurrency in behavioral terms rather than choosing technical mechanisms.
4. **Establish shared understanding.** Present the explanation and ask whether it matches the intended behavior. Resolve corrections and material ambiguities before interpreting it into architecture. Proceed when the user indicates that the explanation is understood and correct, or asks to translate an already agreed explanation. Do not infer agreement from silence or the agent's own confidence. Reuse an explanation already confirmed in the conversation without repeating the checkpoint.

### Stage 2: Interpret the Explanation into Architecture

1. **Derive the domain model within scope.** Extract concepts from nouns, relationships and invariants from constraints, and lifecycle from events in the agreed explanation. Follow the model and data-structure guidance above. Reuse adequate existing models; refine only representations and owners needed by the selected change. Choose core states and representations, assign invariant and transition owners, and explain what the types enforce versus what needs runtime checks. Separate external representations from domain values.
2. **Extract subjects and actions into architecture.** Use the explanation, model, and branches to identify candidate files or classes from responsible subjects and candidate functions from actions. Reuse or consolidate owners where they share domain knowledge. Refine signatures and contracts around the chosen data shapes and valid transitions. A sentence's separate verbs may become one operation when the same owner must enforce a rule, such as Cart.add handling both a new product and an existing quantity. Execution order determines orchestration order; it does not require a separate class, file, or layer for each step.
3. **Show the structure behind the flow.** Map each responsible subject to its existing or proposed file or class, and each action to its function. Use those same owners and functions in the execution tree. Draw relationships between owners in ASCII and label arrows as calls, dependencies, or ownership. Distinguish runtime call direction from type dependency direction when they differ. Justify each new boundary by the complexity it hides or the rule it owns.
4. **Walk through the design.** Follow a representative input and each major branch on paper, including operations at constraint limits and invalid transitions where relevant. Check that every branch has an outcome or continuation, data is available before use, invariants survive mutations, state changes have owners, and failures reach the right boundary. Revise unnecessary layers and repeated decisions. If interpretation exposes a missing or conflicting behavior rule, return to the affected explanation instead of inventing a requirement. List observable acceptance criteria and unresolved assumptions; do not implement or execute verification code.

## Output

**Stage 1:** Start with the plain-language explanation of how the feature works. Include its successful path, major alternatives, rules, and observable outcomes. State the minimum change scope, behavior to preserve, and work outside this increment. End with any material open questions and the shared-understanding checkpoint. Do not include architecture proposals or model-to-code mappings in this stage.

**Stage 2:** Briefly recall the agreed behavior, then show the execution tree near the top. Follow it with the concept and subject/action mapping, ASCII relationships, and necessary contracts. For consequential domain rules, show a compact mapping of requirement -> invariant or precondition -> representation -> enforcement owner. Explain the decisive data-structure choices and state transitions when relevant. End with the consequential design choices, open questions, and acceptance criteria. Scale the supporting detail to the feature; always include the execution tree and relationship diagram in this stage.

Focus Stage 2 on the selected change and show unchanged collaborators only as necessary context. Distinguish reused, changed, and new elements. Explain any necessary scope expansion and connect each proposed change to a current requirement.

### Execution Tree

Show the tree directly in the response inside a fenced `text` block.

- Use connected tree characters (`├──`, `└──`, `│`) and consistent indentation so branches remain visible in monospaced text.
- Start with the entry-point function. Show its direct calls as siblings in execution order, at the same tree depth and a consistent abstraction level. Keep each function's call tree as flat as possible; sequential calls do not become children of the previous call.
- Nest only for actual control flow or an expanded callee's own calls. Prefer guard clauses and early returns where they preserve the behavior and simplify the flow. Do not flatten away a real call relationship or mix low-level mechanisms into an orchestration view.
- Express conditions and repetition as code-like `if condition`, `else if condition`, `else`, and `for item in items`. Show terminal outcomes with `return` or `throw`. Do not use operation numbers, branch labels such as `[valid]`, or markers such as `[END]`.
- Use owner-qualified function calls and short code-like statements. Put argument details, contracts, and explanations outside the tree. Keep lines within roughly 80 columns so the tree is readable in a chat panel.
- Show a loop body once under its `for` statement. Keep a shared continuation once after the branches that reach it. Express an asynchronous handoff as the relevant function call and explain its continuation outside the tree.
- Expand a callee in a separate tree rooted at that function when inline expansion would make the overview deep or repetitive. Use the same function name in both trees, without reference labels.

Example successful path: receive request -> validate -> decide transition -> persist -> respond.

```text
EntryAdapter.handle(request)
├── input = EntryAdapter.parseAndValidate(request)
├── if input.isInvalid
│   └── return EntryAdapter.rejectedResponse(input.error)
├── result = FeatureWorkflow.execute(input.value)
└── return EntryAdapter.response(result)

FeatureWorkflow.execute(input)
├── transition = DomainModel.decideTransition(input)
├── if transition.isDisallowed
│   └── return transition.rejection
├── saved = StorageContract.persist(transition)
├── if saved.failed
│   └── return saved.error
└── return saved.value
```

EntryAdapter translates the workflow result into a response. Its direct calls remain siblings; the separate workflow tree exposes domain decisions and persistence without deepening the entry-point tree. The contracts describe the result cases and failure propagation.

### Class or File Relationships

Use a separate ASCII diagram for class or file relationships. Label actual relationships rather than implying that every execution branch creates a dependency. For example:

```text
[EntryAdapter] --calls--> [FeatureWorkflow] --calls--> [DomainModel]
                                  |
                                uses
                                  v
                           [StorageContract]
                                  ^
                             implements
                                  |
                           [StorageAdapter]
```

Identify whether diagram nodes represent files, classes, or modules. Use real paths and symbols for existing elements and mark proposed elements. Include contract sketches or pseudocode only as explanatory text outside executable paths.

## Done When

Stage 1 is ready for interpretation when the user understands the explanation and it matches the intended behavior. Delivering that explanation alone does not complete the architecture design.

The design closes the stated behavior gap with the smallest complete scope. Each new abstraction or model has a current responsibility, required contracts remain intact, and unrelated improvements have not entered the change.

The user can trace concepts to model representations, constraints to enforced rules, responsible subjects to files or classes, actions to functions, and order and branches to the execution tree. Consequential invariants and state transitions have owners, and each data-structure choice follows from actual rules and access patterns. Each operation has a contract, and the proposed code would read in that execution order. The explanation, domain model, extracted architecture, execution tree, and relationship diagram agree, acceptance criteria are observable, and no implementation has been made.

## Avoid

- Expanding a small change into a system redesign merely to apply design principles everywhere.
- Adding speculative abstractions or unrelated cleanup to the selected scope.
- Minimizing the diff by leaving required behavior incomplete or moving repeated coordination into callers.
- Starting with a class diagram and inventing a flow to justify it.
- Proposing architecture before establishing shared understanding of the feature explanation.
- Mechanically creating a class for every noun or a function for every verb without a meaningful responsibility.
- Choosing data structures only from field names without checking identity, relationships, invariants, and access patterns.
- Assuming a type or collection enforces every invariant, or scattering the same invariant across callers.
- Turning every event into messaging infrastructure or inventing lifecycle rules absent from the requirements.
- Splitting shared domain knowledge into files merely to mirror execution stages.
- Mixing workflow intent with low-level mechanisms in one view.
- Using branch labels instead of explicit code-like conditions, or leaving dependencies and continuations implicit.
- Burying the execution tree after long prose or replacing it with a diagram link, prose, or only a class relationship diagram.
- Enumerating speculative edge cases or creating abstractions without a required responsibility.
- Treating an execution walkthrough as permission to run, implement, or write the design to files.
