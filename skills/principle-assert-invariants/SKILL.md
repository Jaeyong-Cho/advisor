---
name: principle-assert-invariants
description: Actively express internal invariants, programmer-controlled preconditions, and postconditions as runtime assertions when implementing or reviewing code. Keep expected failures and external-input validation in normal error handling.
---

# Assert Invariants

Make conditions that must hold in correct code executable through assertions. Actively look for useful assertions while implementing, especially where a complex mutation should preserve a rule but the implementation could be wrong. An assertion failure signals a violated internal contract or implementation defect.

## Decide What to Assert

Distinguish two kinds of uncertainty:

- **The rule is guaranteed, but the implementation may be wrong:** assert the condition. Examples include a tree remaining valid after an update or successful removal decreasing a stored count by exactly one.
- **The condition may legitimately be false:** validate, reject, or handle the failure normally. Invalid user input, a denied domain transition, missing files, timeouts, and server failures belong here.

Confirm the invariant from the requirement or existing contract before asserting it. An unproven assumption does not become a guarantee because it is written in an assertion.

## How to Apply It

1. **Identify conditions before writing the operation.** Look for internal preconditions, consistent state, postconditions, permitted internal transitions, valid computed ranges, and unreachable branches. Use [Model the Domain](../principle-model-the-domain/SKILL.md) to establish the rule and its owner.
2. **Assert close to the cause.** Place checks at the owning operation's entry, after relevant mutations, or before using a derived result. Actively add checks for meaningful runtime invariants that could be violated by implementation bugs. Prefer prevention through types and data structures where possible; avoid repeating guarantees already enforced without a useful diagnostic reason.
3. **Keep predicates pure.** Assertions and their messages must not mutate state, perform required work, or trigger external I/O. Execute the operation separately, then inspect the resulting state. Use a diagnostic message that identifies the violated rule without exposing sensitive data.
4. **Respect runtime semantics.** Use the language's or project's established runtime assertion facility and check whether assertions are enabled in the relevant build. Some mechanisms can be disabled; for example, [Python omits `assert` under optimization](https://docs.python.org/3/reference/simple_stmts.html#the-assert-statement). Required validation and correctness must not depend on evaluating an optional assertion. Use an always-on check when enforcement is required in production.
5. **Distinguish defects from expected failure.** Follow [Boundary Discipline](../principle-boundary-discipline/SKILL.md) for external data and recoverable failures. Do not catch an assertion failure and continue with corrupted state, replace it with a success result, or use a type cast or non-null assertion as if it were a runtime check.
6. **Verify through the interface.** Run meaningful interface tests with assertions enabled so real execution exercises the invariants. Preserve independent expectations for observable behavior; runtime assertions supplement those tests. Review predicate purity and the actual build configuration. Keep expensive whole-structure checks in an appropriate diagnostic configuration when necessary.

## Good and Bad Examples

### Good: A Tree Update Must Preserve Validity

A correctly implemented update must leave the tree valid. The rule is guaranteed even when the developer is uncertain about the implementation:

```cpp
updateTree();
assert(tree.isValid());
```

The assertion detects an implementation defect close to the mutation. `isValid()` must inspect the tree without changing it.

### Good: Removing One Existing Node Must Decrease Size by One

Assume this internal operation guarantees successful removal of exactly one existing node:

```cpp
const auto oldSize = tree.size();
tree.removeExisting(node);
assert(tree.size() == oldSize - 1);
```

The size change is a postcondition, so a violation indicates a bug. A public request to remove a nonexistent node instead follows the interface's specified rejection or no-op behavior. The mutation occurs outside the assertion so disabling assertions cannot skip the removal.

### Bad: Assuming a Server Must Respond

A server may fail or time out even when the client code is correct:

```cpp
assert(server.responded());
```

This treats an expected external failure as an implementation defect. After the response deadline expires, handle the missing response through the interface's normal failure path instead:

```cpp
if (!server.responded()) {
    return RequestResult::timeout();
}
```

Uncertainty about whether the world will cooperate requires error handling. Uncertainty about whether the implementation preserves an established guarantee is a useful reason to add an assertion.

## Stop When

Meaningful internal guarantees are checked where violations arise, expected failures have explicit handling, predicates are pure, and verification states whether the assertions actually ran. Assertions have not been added merely to meet a count or duplicate every boundary check.
