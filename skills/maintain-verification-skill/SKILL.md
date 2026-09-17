---
name: maintain-verification-skill
description: Keep a project-local verification skill and its feature map accurate by checking every mapped feature from source and through a live run.
disable-model-invocation: true
---

# Maintain Verification Skill

Keep a project-local verification skill and feature map accurate as the application changes. The unit of coverage is a user-facing feature, not every sentence in its documentation.

## When to Use

Use this action for an existing verification skill that has Launch and Drive instructions and a feature map. Run [Create Verification Skill](../create-verification-skill/SKILL.md) when no such skill exists. Apply [Record and Resolve Friction](../record-and-resolve-friction/SKILL.md) to report product gaps found during maintenance.

## Steps

1. Locate the target verification skill, normally `.agents/skills/verify-{app}/`. If several candidates exist, ask which one to maintain. If none exists, stop and create one instead of inventing a target.
2. Check feature-map hygiene. Compare the index and feature files, then correct missing, duplicate, stale, or dead entries in the verification skill's scope.
3. Review every mapped feature against source. Identify its user-facing entry point, current flow, likely documentation drift, and one concise live-verification recipe. Inspect recent user-facing changes for features missing from the map.
4. Reconcile the recipes into the smallest practical set of application states. Confirm suspected drift against source before editing.
5. Run a live pass through every mapped feature. Run the skill's Doctor check before the first drive, after failed drives, and for each fresh instance. Capture evidence and clean up residue created by every iteration.
6. Triage findings within the verification-skill scope. Correct documentation drift and harness gaps, then rerun the affected feature live. Record product behavior that is actually broken without changing product code during this maintenance action.
7. Report one outcome: `clean` when every feature has source and live coverage with no correction, `changed` when proven verification-skill corrections exist, or `blocked` when coverage cannot complete safely. State exact blockers and unreachable prerequisites.

## Done When

Every mapped feature has source and live coverage, all harness changes were rerun live, evidence remains after cleanup, and the outcome is reported honestly. Keep concise run notes outside committed artifacts unless the project requires them.

## Avoid

- Editing application code to make the verification map appear correct.
- Treating source review as a substitute for live verification.
- Driving an instance that has not passed its health check after unexpected behavior.
- Leaving processes, ports, profiles, or scratch state created by a failed run.
- Marking a feature unreachable without the route attempted and its concrete missing prerequisite.
