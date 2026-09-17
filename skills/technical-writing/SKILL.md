---
name: technical-writing
description: Write technical documents that a tired engineer can understand on the first read.
disable-model-invocation: true
---

# Technical Writing

Write so that a tired engineer can understand on the first read. Choose the document's purpose first, address the reader directly, carry one thought per sentence, and remove ambiguity.

## Problem It Solves

When a document mixes explanation, procedure, factual lookup, and opinion, readers must infer both what to do and what to understand. Long sentences, vague pronouns, changing terminology, and filler force readers to interpret meaning. Documentation creates reading cost just as code does.

## How to Apply It

1. **Choose one document purpose.** Choose a tutorial for learning by doing, a how-to for reaching a task goal, reference for facts, or explanation for background and reasons. Split and link content that needs different purposes.
2. **State the reader and action clearly.** Write procedures as commands and put conditions before actions. State facts actively with a clear actor. Present the common case before exceptions.
3. **Keep sentences light.** Put one instruction or thought in each sentence. Remove words that add no meaning and prefer ordinary precise words. Use the real code symbol, path, flag, and command.
4. **Remove ambiguity.** Make every pronoun identify one clear subject; repeat the noun when needed. Put modifiers such as `only` and `not` beside the word they modify. Use one name for one thing throughout the document.
5. **Format for navigation.** Make headings state the point. Use numbered lists for ordered procedures and bullet lists for parallel items. Keep code, UI labels, paths, and commands consistent with reality.
6. **Review from the reader's questions.** Check whether a first reader can find the purpose, action or fact, conditions, exceptions, and evidence. Reduce unnecessary structure and reader burden with [Minimize Reader Load](../minimize-reader-load/SKILL.md).

## Stop When

The document serves one purpose, readers can find actions, facts, conditions, and exceptions without reinterpreting them, and all symbols and paths match the current state.

## Avoid

- Mixing tutorial, how-to, reference, and explanation in one document.
- Hiding actors and actions with passive or abstract language.
- Packing multiple actions, conditions, and reasons into one sentence.
- Calling the same thing by different names.
- Leaving examples with paths, symbols, commands, or numbers that differ from the code.
- Hiding ordinary actions behind jargon, idioms, or decorative language.
