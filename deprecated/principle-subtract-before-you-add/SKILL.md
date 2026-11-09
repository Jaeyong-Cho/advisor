---
name: principle-subtract-before-you-add
description: Remove unnecessary code and complexity before adding new structure.
disable-model-invocation: true
---

# Subtract Before You Add

Before adding new structure during feature work, modification, or refactoring, remove unnecessary code and complexity.

## Problem It Solves

Adding a feature on a complex base combines existing duplication, dead code, and temporary paths with the new change. Removing first reveals real responsibilities and necessary scope, making the addition smaller and safer.

## How to Apply It

1. **Confirm current purpose and use.** Use [Define Goal](../principle-define-goal/SKILL.md) to state required behavior and contracts to preserve. Do not treat speculative future use or support as a current requirement.
2. **Find candidates for removal.** Look for dead code, unused configuration, duplicate validation, empty pass-through layers, replaced interfaces, and temporary workarounds. Confirm actual use and reason for existence before removal.
3. **Remove first and verify.** Remove a small candidate and use [Closed Working Loop](../principle-closed-working-loop/SKILL.md) to check preserved behavior. Use the simpler structure as the base for the next change.
4. **Add only the minimum structure.** Add only code and checks directly required by the new behavior. Decide on retries, persistence, migrations, and extension points only after confirming a real need and cost.
5. **Check that the result remains simple.** Confirm that the same responsibility can be explained with fewer concepts and paths than before. Do not remove required behavior or safety conditions for simplicity.

## Stop When

You have removed unnecessary base complexity and verified the minimum change needed to reach the goal. Do not force deletion when no evidence supports it.

## Avoid

- Treating deletion as the goal and removing necessary behavior and contracts.
- Deleting code without checking its use or reason for existence.
- Adding configuration, checks, or extension points merely because they may be useful later.
- Combining a large cleanup and feature change so that the verification scope is unclear.
