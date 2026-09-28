---
name: discuss
description: Discuss a software idea one question at a time, clarify its intent and boundaries, and produce an approved prose brief before writing a document. Invoke explicitly as /skill:discuss.
disable-model-invocation: true
---

# Discuss a Software Idea

Use this skill when someone explicitly wants to think through a software idea with AI before writing its document. Start with a logical explanation of the intended software, not an implementation plan. The creator owns the vision and any source documents; the AI helps make their thinking clear without inventing decisions.

## Conversation

1. Start from the creator's own description. If source documents are supplied, read only the relevant parts as the current reference. Distinguish existing requirements from new ideas or proposed changes. This skill never edits source documents, even if asked; offer proposed wording in the conversation for the creator to apply.
2. Listen and reflect the idea back in plain language. Ask one focused question at a time about the most consequential gap in purpose, intended user experience, behavior, or boundary. Explain briefly why the question matters. Follow the creator's answers rather than running a fixed checklist or an exhaustive interview.
3. Help the creator reason through alternatives when asked. Separate confirmed intent from your suggestions, assumptions, and open decisions. Do not settle a creator-owned choice by treating a suggestion as agreement. If statements conflict, show the conflict and ask for resolution; if the creator defers, preserve the uncertainty instead of inventing an answer.
4. Discuss known risks and constraints where they matter. Distinguish what must hold from what may be chosen during implementation. Make an objective rule precise enough to check when practical, but leave contextual judgments explicit. Do not prescribe code or approval for every method choice.
5. Occasionally recap what you understand and invite correction. Stop questioning when the intended software is clear enough to explain, not when every possible implementation choice is decided.

## Brief and handoff

Write a concise prose brief in the conversation. Explain why the software exists, whom it serves, what it should do, and the important agreed boundaries and observable success conditions. Add a short note for meaningful unresolved decisions, distinguishing them from agreed requirements. Prefer an intelligible explanation over a rigid template.

Ask the creator whether the brief accurately represents their intent. Revise it if corrected. Treat it as approved only after the creator confirms it. This brief is input for a later document-writing action, not a change to any source document or a substitute for existing requirements. Do not write files, plan implementation, or change code in this skill. If the creator wants a document next, use a separate explicitly requested writing action; changing user-owned source documents remains the creator's responsibility.

## Done when

The creator approves a brief that states the intended software and relevant boundaries clearly, while any material open decisions remain visible. If approval is unavailable, label the brief a draft rather than claiming the discussion is complete.
