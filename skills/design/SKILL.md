---
name: design
description: Derive a feature's architecture from its behavior explanation by extracting subjects as files or classes, actions as functions, and execution order and branches as a flow tree, without implementation.
---

# Design

Explain how a feature works from its entry point, then derive its architecture from that explanation. Subjects identify who owns the work, actions identify what they do, and the explanation's order and branches describe execution. Design the code so its orchestration can read in that same order.

Produce design artifacts only. Do not implement, create executable scaffolding, or run the proposed flow. Inspect existing code when needed; label proposed behavior separately from observed behavior.

## Derive Architecture from the Explanation

Write each meaningful step as **subject -> action -> outcome**, including the input or condition when needed. Make the subject explicit rather than hiding responsibility in passive descriptions.

| Element in the explanation | Design element |
| --- | --- |
| Subject responsible for work | File or class that owns the responsibility |
| Action performed by a subject | Function owned by that file or class |
| Order of actions and branch conditions | Execution flow from the entry point |
| Interaction between subjects | Call, dependency, or ownership relationship |

These are candidates to refine with the principles below. A data object or external actor mentioned in the explanation is not automatically a new class. Repeated subjects can share an existing owner, and related actions can belong to one deep module. Keep each proposed file, class, and function traceable to the behavior it supports.

## Principles

Read these principles before designing. Apply their decision rules where relevant and name the rules that explain consequential choices. Read their supporting references only when needed.

- [Abstraction Levels](../principle-abstraction-levels/SKILL.md): keep orchestration at the level of intent, domain decisions separate, and technical mechanisms behind meaningful operations.
- [Deep Module](../principle-deep-module/SKILL.md): group related complexity behind contracts that reduce caller knowledge and coordination.
- [Boundary Discipline](../principle-boundary-discipline/SKILL.md): validate and convert external inputs at entry boundaries, and assign responsibility for translating failures at exit boundaries.
- [First Principle Redesign](../principle-first-principle-redesign/SKILL.md): derive the flow from purpose and required outcomes rather than assuming current classes and layers must remain.
- [Foundational Thinking](../principle-foundational-thinking/SKILL.md): establish core data shapes and ownership before detailing operations; identify shared state when concurrency matters.
- [Model the Domain](../principle-model-the-domain/SKILL.md): express states and transitions explicitly, and keep the same domain knowledge together even when it is used at different execution stages.
- [Type System Discipline](../principle-type-system-discipline/SKILL.md): in statically typed systems, make inputs, outcomes, and branch cases explicit in types without unsafe escapes.
- [Subtract Before You Add](../principle-subtract-before-you-add/SKILL.md): identify existing responsibilities to reuse, merge, or remove before proposing new structure.
- [Laziness Protocol](../principle-laziness-protocol/SKILL.md): minimize concepts, pass-through calls, and value propagation while preserving required behavior.

## Steps

1. **Establish the feature contract.** State its purpose, trigger, entry point, inputs, observable outcomes, and constraints. Inspect the relevant current flow and distinguish requirements from implementation accidents. Ask only for missing information that could materially change the design.
2. **Explain execution from the entry point.** Describe the main successful path in subject-action-outcome sentences before choosing class or function names. At each step, identify data consumed and produced, state changes, and side effects. Use domain operations at the orchestration level; expand mechanisms only when they affect the design.
3. **Expose the major branches.** Add decisions that change the outcome, state transition, side effect, or next operation. Label conditions, alternate paths, and terminal outcomes. Include consequential validation and failure paths. Show loops, retries, asynchronous handoffs, and concurrency only when required, with their continuation or stopping conditions.
4. **Extract subjects and actions into architecture.** Use the explanation and its branches to identify candidate files or classes from subjects and candidate functions from actions. Reuse or consolidate owners where they share domain knowledge. Define core states and data shapes before refining function signatures and contracts. Separate external representations from domain values. Execution order determines orchestration order; it does not require a separate class, file, or layer for each step.
5. **Show the structure behind the flow.** Map each subject to its existing or proposed file or class, and each action to its function. Use those same owners and functions in the execution tree. Draw relationships between owners in ASCII and label arrows as calls, dependencies, or ownership. Distinguish runtime call direction from type dependency direction when they differ. Justify each new boundary by the complexity it hides or the rule it owns.
6. **Walk through the design.** Follow a representative input and each major branch on paper. Check that every branch has an outcome or continuation, data is available before use, state changes have owners, and failures reach the right boundary. Revise unnecessary layers and repeated decisions. List observable acceptance criteria and unresolved assumptions; do not implement or execute verification code.

## Output

Start with a brief feature contract and a one-line summary of the successful path, then show the execution tree. Follow it with the explanation, subject/action mapping, ASCII relationships, and necessary contracts. End with the consequential design choices, open questions, and acceptance criteria. Scale the supporting detail to the feature; always include the execution tree and relationship diagram.

### Execution Tree

Show the tree directly in the response under an **Execution tree** label, inside a fenced `text` block. A link to a saved artifact does not replace the visible tree.

- Use connected tree characters (`├──`, `└──`, `│`) and consistent indentation so branches remain visible in monospaced text.
- Start with the entry point. Number operations in execution order and show the owner and function on each operation node.
- Label alternatives with explicit conditions such as `[valid]` or `[invalid]`. Nest the next operation under the branch that reaches it, and mark terminal outcomes with `[END]`.
- Distinguish an operation's internal steps from its conditional branches through numbered operation labels and bracketed conditions. Sibling operations run in numbered order; sibling conditions are alternatives.
- Keep node labels short. Put argument details, contracts, and explanations outside the tree. Keep lines within roughly 80 columns so the tree is readable in a chat panel.
- Use references for shared continuations, loops, or asynchronous handoffs when expanding them would duplicate a large subtree. Define the destination and continuation condition explicitly. Keep ordinary branch continuations inline.
- For a large flow, show the major branches in an overview first, then expand relevant subtrees in separate labeled blocks.

Example successful path: receive request -> validate -> decide transition -> persist -> respond.

```text
EntryAdapter.handle(request) [entry point]
└── 1. EntryAdapter.parseAndValidate
    ├── [invalid] Return rejected response [END]
    └── [valid] 2. FeatureWorkflow.execute
        └── 3. DomainModel.decideTransition
            ├── [disallowed] Return domain rejection [END]
            └── [allowed] 4. StorageContract.persist
                ├── [failure] Return error response [END]
                └── [success] Return completed response [END]
```

The response outcomes above are translated by EntryAdapter. The tree shows the paths that reach those outcomes; the contract describes the failure propagation.

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

The user can trace the explanation's subjects to files or classes, actions to functions, and order and branches to the execution tree. Each operation has an owner and contract, and the proposed code would read in that execution order. The explanation, extracted architecture, execution tree, and relationship diagram agree, acceptance criteria are observable, and no implementation has been made.

## Avoid

- Starting with a class diagram and inventing a flow to justify it.
- Mechanically creating a class for every noun or a function for every verb without a meaningful responsibility.
- Splitting shared domain knowledge into files merely to mirror execution stages.
- Mixing workflow intent with low-level mechanisms in one view.
- Drawing unlabeled branches, dependencies, or implicit continuations.
- Burying the execution tree after long prose or replacing it with a diagram link, prose, or only a class relationship diagram.
- Enumerating speculative edge cases or creating abstractions without a required responsibility.
- Treating an execution walkthrough as permission to run or implement the feature.
