# TDD

Implementation always follows TDD: one behavior at a time, RED → GREEN → REFACTOR.

Use the test setup and commands discovered in the project. For interface design for testability, read [Deep Modules](deep-modules.md). For test boundaries and scope, read [Testing by level](abstraction-levels.md#testing-by-level).
Read good and bad test examples [Tests](tests.md) and mocking methodology [Mocking](mocking.md).

---

## Philosophy

**Core principle**: Tests verify behavior through public interfaces — not implementation details. Code can change entirely; tests shouldn't.

**Good tests** are integration-style: exercise real code paths through public APIs. Describe *what* system does, not *how*. Good test reads like specification — "user can checkout with valid cart" tells exactly what capability exists. Survive refactors because they don't care about internal structure.

**Bad tests** coupled to implementation: mock internal collaborators, test private methods by default, or assert internal call order. Warning sign: test breaks when you refactor, but behavior hasn't changed.

---

## Anti-Pattern: Horizontal Slices

**DO NOT write all tests first, then all implementation.** This is "horizontal slicing" — treating RED as "write all tests" and GREEN as "write all code."

Produces bad tests:
- Tests written in bulk test *imagined* behavior, not *actual* behavior
- End up testing *shape* of things (data structures, signatures) rather than user-facing behavior
- Tests become insensitive to real changes — pass when behavior breaks, fail when behavior is fine
- Commit to test structure before understanding implementation

**Correct approach**: Vertical slices via tracer bullets. One test → one implementation → repeat.

```
WRONG (horizontal):
  RED:   test1, test2, test3, test4, test5
  GREEN: impl1, impl2, impl3, impl4, impl5

RIGHT (vertical):
  RED→GREEN: test1→impl1
  RED→GREEN: test2→impl2
  RED→GREEN: test3→impl3
```

---

## Workflow

### 1. Before writing any code

From the confirmed request or design, extract the required behavior list:

- [ ] Which value-layer entry points are being added or changed?
- [ ] Which entity actions or behaviors need verification?
- [ ] Which behaviors are most critical? (test those first)
- [ ] Resolve only missing requirements that could change expected outcomes

**Can't test everything.** Focus on critical paths and complex logic, not every edge case.

### 2. Tracer bullet

Write ONE test for first behavior — most end-to-end path that proves wiring works.

```
RED:   test fails (behavior doesn't exist yet)
GREEN: minimal code to make it pass
```

### 3. Incremental loop

For each remaining behavior from plan:

```
RED:   write next test → fails
GREEN: minimal code to pass → passes
```

Rules:
- One test at a time
- Only enough code to pass current test
- Don't anticipate future tests

### 4. Refactor

After each behavior's tests are green, check for simplifications within the change scope (see [Deep Modules](deep-modules.md)):

- [ ] Can any interface be narrowed?
- [ ] Is complexity hidden or exposed?
- [ ] Any duplication to extract?

Run tests after each refactor step. **Never refactor while RED.**
