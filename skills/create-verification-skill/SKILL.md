---
name: create-verification-skill
description: Create a project-local skill that launches, drives, observes, and cleans up a real application verification run.
disable-model-invocation: true
---

# Create Verification Skill

Create a project-local verification skill that drives the real application as a user would and preserves evidence of the observed behavior.

## When to Use

Use this action when a project has no scripted path to prove UI, CLI, service, desktop, or mobile behavior through the real application. Apply [Closed Working Loop](../principle-closed-working-loop/SKILL.md) to select meaningful evidence and [Build the Lever](../principle-build-the-lever/SKILL.md) to keep the harness rerunnable.

## Steps

1. Inspect the repository before asking the user. Identify the primary user-facing surface, local startup command, required ports, environment variables, seed data, authentication, and secondary surfaces.
2. Find existing ways to drive the application. Prefer existing browser tests, CLI scripts, PTY helpers, HTTP endpoints, debug ports, or test harnesses. Select the least invasive driver that exercises the real user path.
3. Define observable evidence: screenshots, terminal transcripts, response bodies, logs, exit codes, files, database state, or other side effects. Capture both the action and resulting state.
4. Determine isolation and cleanup. State whether instances can run in parallel and how to avoid shared ports, profiles, data directories, or user sessions. Clean up only processes and scratch state created by the run; preserve evidence.
5. Create `.agents/skills/verify-{app}/SKILL.md` with concrete Launch, Doctor, Drive, Evidence, Cleanup, and Helpers sections. Use real commands, selectors, routes, prompts, and artifact locations from the repository.
6. Create `.agents/skills/verify-{app}/features/README.md` and a feature file for each initial user-facing feature. Describe what it is, how a user reaches it, how the harness drives it, observable success, and relevant gotchas.
7. Run the generated skill end to end for one mapped feature: launch, doctor, drive, capture evidence, clean up, and confirm the evidence remains. Correct any failure and rerun the full path.

## Done When

The verification skill has no placeholders, can safely launch and drive one real user-facing feature, captures evidence that survives cleanup, and has an initial feature map for later coverage.

## Avoid

- Writing a skill against an application that cannot build or start without first recording the blocking condition.
- Driving internal setters or test-only endpoints instead of the real user path.
- Using coordinates and tab order when stable selectors, prompts, or routes exist.
- Killing by process name or deleting captured evidence during cleanup.
- Delivering a generated skill that has never run successfully.
