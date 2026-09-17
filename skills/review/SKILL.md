---
name: review
description: Run a strict maintainability review for abstraction quality, code structure, file growth, boundaries, types, and branching complexity.
disable-model-invocation: true
---

# Review

Perform a strict implementation-quality review of a specified code scope or the current diff. Look for structural simplifications that preserve behavior and make the code smaller, more direct, and easier to change.

## When to Use

Use this skill after implementation, during Chill Mode, or before accepting a substantial change. Apply [Understand Through Abstraction](../understand-through-abstraction/SKILL.md) before judging unfamiliar code. Use [Deep Module](../deep-module/SKILL.md), [Minimize Reader Load](../minimize-reader-load/SKILL.md), [Laziness Protocol](../laziness-protocol/SKILL.md), [Boundary Discipline](../boundary-discipline/SKILL.md), and [Type System Discipline](../type-system-discipline/SKILL.md) as review criteria where relevant.

## Steps

1. Define the scope. Use the specified files or diff; otherwise inspect the current diff against the base branch.
2. Understand changed functions and module boundaries from their contracts inward. Establish their responsibility, caller burden, state changes, side effects, and preserved behavior before proposing a change.
3. Look first for structural simplification. Ask whether a different ownership boundary, state model, or direct flow can remove branches, helpers, modes, layers, or duplicated decisions instead of merely rearranging them.
4. Review changed boundaries and interfaces. Flag shallow modules, pass-through methods, duplicated logic, information leakage, temporal coupling, hidden side effects, and contracts that expose implementation steps.
5. Review abstraction levels. Separate workflow and public contract, domain rules and state transitions, and technical mechanisms. Flag a function that mixes these levels without a meaningful reason or leaks mechanism details into a higher-level contract.
6. Review growth and coupling. Treat a file crossing from below 1,000 lines to above 1,000 lines as a strong signal to decompose. Flag feature-specific logic inserted into unrelated shared flows, ad-hoc conditional growth, repeated flags, scattered special cases, and non-atomic related updates.
7. Review types and boundaries. Flag unnecessary casts, `any`, `unknown`, optionality, loosely shaped objects, silent fallbacks, duplicated validation, and framework or transport details leaking into domain logic.
8. Recommend the smallest meaningful remedy. Prefer deletion, consolidation, a narrower contract, a clearer model, a pure helper, an existing canonical utility, or moving logic to its actual owner.

## Findings Format

Return at most three findings, ordered by impact. For each finding, include a concrete location, the violated principle, the maintainability impact, a separate fenced example, and a recommended handling.

```md
## Finding: <short title>

- **Location:** <path and symbol>
- **Principle:** <relevant principle>
- **Problem:** <what is structurally wrong>
- **Impact:** <why this increases reader or change cost>
- **Recommended handling:** <smallest meaningful change>

```text
<short illustrative example>
```
```

Report `Violation: None` when no in-scope structural issue remains. Use [Friction](../friction/SKILL.md) to propose durable recording for a confirmed finding that will not be addressed now.

## Approval Bar

Do not approve only because behavior works. Approve when no clear structural regression, avoidable file-size explosion, obvious spaghetti growth, unnecessary wrapper or cast-heavy contract, boundary leak, or visible opportunity for a materially simpler design remains.

## Avoid

- Flooding the review with cosmetic nits while higher-impact structural issues exist.
- Demanding mechanical extraction that creates no meaningful concept or boundary.
- Calling code a smell before understanding its responsibility and constraints.
- Treating a local guard or default value as a design remedy when it hides a causal problem.
- Recommending broad rewrites without preserving behavior and naming a concrete simplification.
- Editing the reviewed code as part of this skill. Present findings and let the calling workflow decide what to apply.
