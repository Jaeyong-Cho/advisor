---
name: archive
description: Archive supplied files or directories as deduplicated Google Open Knowledge Format concepts in a target directory. Invoke as /archive.
disable-model-invocation: true
---

# Archive

Archive supplied knowledge without creating duplicates. Convert each source into an Open Knowledge Format version 0.2 concept and preserve its provenance.

Require two inputs before writing.

- One or more resolved source paths, or pre-qualified session knowledge from [Learn](../learn/SKILL.md).
- One resolved absolute target archive directory.

Leave every source unchanged.

For a Learn candidate, a source may use a stable session resource descriptor such as session:<topic>. Preserve any direct artifact source that supports the candidate.

## Archive Structure

Every concept document must have this path from the target archive directory.

~~~
<category>/<sub-category>/<topic>.md
~~~

Use lowercase kebab-case names. Choose category and sub-category from the source subject. Choose a stable topic name that names the concept rather than its source filename.

index.md is the only exception. It lives at the target archive root and is not a concept document.

## Inspect Before Writing

1. Read the supplied files. For a supplied directory, recursively read the relevant text, Markdown, and source-code files. Report files that cannot be interpreted as text and leave them unchanged.
2. Read the root index.md when it exists. Search every existing concept for candidate matches by title, description, tags, headings, resource, and substantive claims.
3. Treat an existing concept as a match only when its primary subject and scope match the source. A shared keyword, category, or tag is not enough.
4. If one matching concept exists, update it in place. If no match exists, create one concept at the required path. If multiple candidates are plausible or the source contradicts existing knowledge, stop and ask the user which concept should change.

## Write an OKF Concept

Every created concept must have valid YAML frontmatter. Use the most specific type that the source supports. Use Reference when no more specific type is justified.

~~~
---
type: Reference
title: <human-readable title>
description: <one-sentence description>
tags: [<relevant-tag>]
status: draft
generated: { by: archive/1.0.0, at: <ISO-8601 timestamp> }
sources:
  - id: <stable-source-id>
    resource: file:///<absolute-source-path>
    title: <source filename or supplied title>
---

# Summary

<The durable knowledge from the source.>

## Details

<Relevant structure, facts, decisions, examples, or constraints.>
~~~

Add one sources entry for each source that materially contributes to the concept. Use standard Markdown links and source footnotes when a claim needs per-claim attribution.

On update, merge new knowledge into the existing concept. Preserve valid existing frontmatter and body content that the source does not change. Update generated with the current archival event. Set status to draft unless the updated content receives a new human verification. Retain prior verified entries as historical evidence.

Do not copy source material verbatim when a precise summary preserves the needed knowledge. Preserve exact commands, contracts, schemas, quotations, and examples when paraphrasing would lose meaning.

## Update the Index

Create or update <target-archive-directory>/index.md. It has no YAML frontmatter.

List each concept exactly once under its category and sub-category. Use the concept title and frontmatter description.

~~~
# Archive

## <Category> / <Sub-category>

* [<Title>](<category>/<sub-category>/<topic>.md) - <description>
~~~

Keep entries alphabetized by category, sub-category, and title. Update an existing entry instead of appending a duplicate.

## Verify

Before reporting completion, confirm all of the following.

- Each changed concept has a parseable YAML frontmatter block with a non-empty type.
- Each concept path follows <category>/<sub-category>/<topic>.md.
- Each changed concept records every material source.
- The root index.md links each changed concept exactly once with its current description.
- Source files remain unchanged.

## Done When

The target archive contains one updated or newly created concept for every archival subject. No ambiguous or contradictory match was changed without user direction. Every changed concept is discoverable from the root index and carries source provenance.
