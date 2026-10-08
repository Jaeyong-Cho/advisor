---
name: worktree
description: Prepare an isolated Git worktree for a task when the user requests one, reusing a suitable assigned worktree or creating a new one.
---

# Worktree

Prepare a dedicated Git worktree for the current task. This skill handles workspace isolation only; continue the task with its relevant implementation or review workflow afterward.

## Steps

1. Resolve the target repository root. Inspect its current branch, `HEAD`, local changes, and existing worktrees. Use a user-specified base when provided; otherwise use the target checkout's current `HEAD`.
2. Preserve unrelated local changes. If the task depends on uncommitted changes, establish how those changes will be included in the worktree. Do not silently start from a version that omits required changes.
3. Reuse a suitable non-primary worktree already assigned to this task when its base and changes fit. Otherwise create a dedicated worktree with the host's worktree manager, or `git worktree add` when no manager is available. Use the repository's branch convention, defaulting to `<feature,bugfix,refactor>/<task-slug>`. Pass the intended base explicitly so a manager's remote-default behavior does not select a different starting point. Do not reset or repurpose another task's checkout.
4. Confirm the worktree's absolute path, Git root, branch, and starting commit. Read its applicable project instructions and use that path for task edits, builds, and verification. Keep artifacts with the worktree or in the project's designated output location.
5. Leave the worktree available for review. Do not merge its changes into the original checkout or force-remove it as part of this skill.

If worktree creation or selection fails, resolve the blocker before editing the Git repository. Report the failure and do not silently fall back to editing the original checkout.

## Completion

Report the worktree path, branch, starting commit, relevant uncommitted changes carried into it, and any setup issue. The implementation or review task is complete only after its own workflow finishes.
