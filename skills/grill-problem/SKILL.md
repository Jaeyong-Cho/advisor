---
name: grill-problem
description: Interview the user to establish why a problem is worth addressing, then generate a prompt for grill-with-docs to decide what to do.
disable-model-invocation: true
---

# Grill Problem

Use the `grilling` skill to interview the user in rounds about why the problem is worth addressing. Identify the problem only far enough to discuss its impact. Ask who feels that impact, what evidence shows it, what happens if things stay as they are, and why it deserves attention now. When the user starts with a proposed solution, ask what prompted it and treat the proposal as context for the next interview.

Recap why the problem deserves attention and ask the user to confirm. After confirmation, return one copy-ready prompt in a fenced block. Begin it with `/grill-with-docs` and give it a short problem statement, the confirmed rationale, and relevant evidence or repo paths when known. Ask it to use that rationale to decide what to do, including scope, success criteria, and solution choices. Carry forward any proposals as open options. Make the prompt understandable in a fresh conversation.

End the skill by returning the prompt to the user for manual invocation.
