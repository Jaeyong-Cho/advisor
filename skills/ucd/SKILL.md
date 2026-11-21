---
name: ucd
description: Explain the intent of code changes in a PR, MR, branch, commit, range, or working-tree diff, broken into small purposeful changes and ordered from high-level contracts to implementation details. Use when the user asks to understand a diff or invokes ucd.
---

# Understand Code Diff

Explain what a change is trying to achieve and why each small change contributes to it. Build a mental model from higher-level responsibilities down to implementation details, using unchanged code wherever it is a prerequisite for understanding.

## 1. Resolve the Comparison

Identify the repository and the user's requested unit. State the comparison and any assumptions before explaining it. Preserve explicit bases, paths, ranges, and exclusions.

| Requested unit | Comparison |
| --- | --- |
| PR or MR | The provider's change diff, with its actual base and head revisions and linked description or discussion when available. |
| Branch | Changes from the merge-base with the intended target branch to the requested branch tip. Use an explicit base when supplied; otherwise inspect repository or PR/MR metadata to establish the target. |
| Commit | Its parent to that commit. For a root commit, compare against the empty tree. For a merge commit, identify the parent being compared; ask if the intended view is unclear. |
| Commit range | Preserve the requested semantics: `A..B` compares the two endpoints; `A...B` compares their merge-base to `B`. |
| Unstaged / unstage | Index to working tree (`git diff`). Untracked files are separate and are not part of this diff. |
| Staged | HEAD to index (`git diff --cached`). |
| All local changes | HEAD to working tree, including staged and unstaged edits; inspect untracked files separately and label them. |
| Supplied patch | Explain the supplied patch and use available repository context to fill in prerequisites. State when its base or surrounding code is unavailable. |

Use available read-only Git and provider tools. Resolve a bare PR/MR number against the current repository rather than guessing another repository. If multiple plausible targets would materially change the explanation, ask a focused question before selecting one. With no scope, inspect local status to identify candidates and ask which comparison the user wants.

Read the complete selected diff, including additions, deletions, renames, tests, and configuration changes. Inspect both revisions where needed; distinguish selected historical code from unrelated current working-tree edits. Report unavailable or truncated content as a coverage gap. Keep this workflow read-only: it explains changes without checking out branches, editing code, or posting a review.

**Complete when:** the selected base/head or local layers are explicit and every changed path in scope has been accounted for.

## 2. Establish Intent and Prerequisites

Use the diff, surrounding code, callers, tests, and available commit or PR/MR context to establish:

- The problem, constraint, or desired behavior motivating the change.
- The relevant behavior before the change and the resulting behavior after it.
- The contracts and responsibilities connecting the changed pieces.

Treat descriptions and commit messages as stated intent; verify their claimed effect against the code. Separate that evidence from inferred rationale. When motivation is unavailable, explain the observable effect and mark the likely intent as an inference rather than inventing a history.

Identify concepts and unchanged code the reader must understand first. Explain only the prerequisites needed for this diff, immediately before their first use. Label them as existing context so they are not mistaken for changes. A necessary entry point, interface, caller, state model, or helper may therefore appear before any changed code.

**Complete when:** the overall purpose has evidence or an explicit uncertainty, and each changed behavior has enough surrounding context to explain its role.

## 3. Divide into Small Intent Units

Group changes by the smallest independently explainable purpose. A unit may span several files or hunks; a single file may contain several units. Name each unit by the outcome it enables, such as “preserve the requested heading while loading a document,” rather than a mechanical edit such as “add a field.”

For a large or multi-purpose diff, first explain the overall intent and map its major purposes. Then break each purpose into small units. Preserve separate purposes when there is no single supported objective tying the diff together.

Order units by abstraction, from the highest relevant level downward:

1. User-visible behavior, domain rules, and public contracts.
2. Entry points, orchestration, and responsibility boundaries.
3. State transitions, data transformations, and algorithms.
4. Supporting helpers, storage, configuration, and mechanical details.

These are ordering guides, not required sections. A configuration or storage change can define the central contract; order by its role in this change rather than by file type. Explain prerequisites before the unit that needs them, even when that requires briefly introducing lower-level existing code. Place tests alongside the intent they substantiate.

**Complete when:** every meaningful change belongs to an intent unit, each unit has a clear contribution, and the explanation order follows abstraction and prerequisites rather than diff or filename order.

## 4. Explain the Change

Respond in the user's language. Scale the explanation to the diff: a small change can use one compact explanation; a large diff needs an overview followed by the ordered small units. Deliver the full explanation without requiring the user to request each next unit.

Start by stating the comparison. For a large diff, give the overall intent before detailed code context. Then introduce any shared prerequisites, followed by the intent units in the order established above.

For each unit, connect these points in plain prose:

- **Intent:** what problem this unit addresses and how it contributes to the larger purpose.
- **Before → after:** the concrete behavior or responsibility that changes.
- **Mechanism:** the relevant symbols and interactions that produce that effect, with prerequisite context explained first.
- **Evidence:** code locations and relevant tests or stated rationale; identify inference and unresolved gaps locally.

Use a concrete scenario when it makes the behavioral difference clearer. Cite precise paths and symbols, with revision information when needed to distinguish old and new code. Include short code excerpts only when they materially help explain the mechanism. Describe test assertions as evidence of intended behavior; claim runtime verification only when it was actually performed.

Account for mechanical or generated changes briefly and connect them to the intent they support. Explain a removal by the behavior or responsibility it eliminates. Keep attention on understanding the selected changes rather than expanding into a general code review or a redesign proposal.

**Complete when:** the reader can explain the overall intent, why each small unit is needed, and how the units produce the before/after behavior, with evidence and uncertainty distinguished.
