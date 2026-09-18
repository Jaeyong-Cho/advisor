---
name: commit
description: Create a Git commit using the repository's established message convention and a body that records why and what changed.
disable-model-invocation: true
---

# Commit

Create one reviewable Git commit with a message that fits the repository and explains the change.

## Steps

1. Inspect the working tree, staged diff, and relevant validation results. Keep unrelated changes out of the commit.
2. Inspect recent non-merge commit subjects and bodies to identify the established convention: type or scope syntax, capitalization, tense, language, punctuation, and body layout. Follow the clearest current convention for the subject.
3. When history has no usable message convention, write the subject as `<type>(topic): brief`. Choose the type that matches the change: `feat` for new behavior, `fix` for a correction, `refactor` for an internal restructuring, and `chore` for maintenance or tooling. Use another conventional type, such as `docs`, `test`, `ci`, `build`, or `perf`, when it describes the change more accurately. Choose `topic` from the changed responsibility and make `brief` a concise description of the outcome.
4. Write a detailed commit body even when the repository history usually omits one. It must contain both sections:

   ```text
   Why:
   - <the problem, user need, or reason for the change>

   What:
   - <the behavior, code, or artifact changed>
   ```

   State concrete reasons and outcomes. Do not substitute file names, generic phrases, or a validation log for `Why` or `What`.
5. Review the exact staged files and complete message. Present both for explicit human confirmation before creating the commit.
6. Create the commit with the confirmed subject and body. Do not amend, rebase, reset, or alter existing commits unless the user explicitly asks.
7. Report the resulting commit hash, subject, and validation evidence.

## Message Rules

- Repository convention determines the subject format. The fallback `<type>(topic): brief` applies only when no usable convention exists; use `feat(topic): brief` for a new feature.
- `Why` explains the motivation or problem addressed.
- `What` explains the resulting behavior or concrete change.
- Keep the subject focused on one coherent change. Split unrelated staged work into separate commits before asking for confirmation.

## Done When

The commit contains only the intended change, follows the repository's subject convention or the fallback format, includes a clear `Why` and `What` body, and its hash and validation evidence are reported.
