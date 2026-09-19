---
name: principle-abstraction-levels
description: Separate intent, domain rules, and technical mechanisms when designing, implementing, or reviewing functions and their dependencies.
---

# Abstraction Levels

Keep each function at one level so code reads as a description of the system and reveals implementation details only when needed.

## How to Apply It

- Name the unit and scale being examined before classifying. L1/L2/L3 repeats inside services, files, classes, and functions; a mechanism can have its own internal orchestration without excusing mixed levels.
- **L1 expresses intent.** Describe the caller's workflow through meaningful operations.
- **L2 expresses domain behavior.** Keep business rules, calculations, policies, and state transitions independent of concrete infrastructure.
- **L3 expresses mechanisms.** Isolate database, HTTP, SDK, filesystem, and serialization operations.
- Call downward, never upward. Same-level composition is valid. L1 may call an L3 operation directly when no domain rule is needed and the call still reads as intent; this does not justify inlining raw infrastructure calls.
- Let L2 depend on an L3 interface, not its concrete implementation.
- Before changing an L1 flow, identify its domain operations and required mechanisms. Distinguish a justified level skip from a missing business rule.
- Treat public/private accessibility separately from abstraction level. Public L2 methods can expose meaningful domain behavior.
- Extract meaningful concepts, not arbitrary blocks based on length. Prefer names that explain domain intent and hide mechanics without hiding meaning.

Read the [full rules and examples](references/abstraction-levels.md) when classifying ambiguous code, reviewing dependency direction, or choosing a decomposition. The reference is preserved from the supplied document; its mentions of other source documents are background references, not bundled dependencies.

## Verification

Choose verification by behavior and failure risk. Use workflow checks for consequential L1 behavior, unit tests for meaningful L2 rules, and integration or contract tests for L3 behavior that depends on real infrastructure. Avoid tests that only assert orchestration call order. TDD is optional; add a failing regression before a bug fix when practical.

## Stop When

The flow communicates intent, domain rules remain visible, mechanisms are isolated, and dependencies respect the levels at the chosen scale. Use [Deep Module](../principle-deep-module/SKILL.md) to judge whether the resulting interfaces reduce caller burden.
