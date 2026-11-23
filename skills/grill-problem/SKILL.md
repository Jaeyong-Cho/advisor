---
name: grill-problem
description: Follow the reasons and evidence behind the user's initial framing to reach a problem definition they can confirm.
disable-model-invocation: true
---

# Grill Problem

## Interview

Use the `grilling` skill to ask questions in rounds. Keep the question tree focused on what could change the problem definition. Ground recommended answers in what is known and mark hypotheses as provisional.

Treat the user's initial framing as provisional. Start from a concrete instance of the problem. If the user starts with a proposed solution, ask what happened that made them want it. Use any instance already in the conversation.

Use each round's answers to decide which links to probe next.

- **What happened?** Ask who was trying to do what, under which conditions, and where they got stuck.
- **Why does it happen?** When an answer names a cause, ask what observation connects it to the outcome. If plausible explanations compete, ask for an instance where the problem was absent or turned out differently.
- **Why does it matter?** When an answer names an impact, ask what that changes for the affected person or their work. Follow the consequences until it is clear what is at stake if the situation continues.

Use available evidence to check verifiable claims. Revise the tentative problem when an answer changes who is affected, where the difficulty arises, or what is at stake. Keep unverified explanations provisional.

## Confirm the problem

Propose a short problem statement once you can name who is affected, what they are trying to do, what gets in their way, and what consequence makes it worth addressing. Ground it in a concrete example or other evidence. If a material gap remains and the interview cannot resolve it, state a provisional definition and name the observation that would clarify it.

Show the user the definition, the reason it matters, and any material uncertainty. Ask whether this captures the problem they want to address. If they correct the framing, resume the interview from that correction.

After the user confirms, return one copy-ready prompt in a fenced block for manual invocation. Start it with `/grill-with-docs`, then include the confirmed problem, why it matters, relevant evidence or repo paths, and any remaining uncertainty. Ask it to explore scope, success criteria, and solution choices. Carry forward previous proposals as open options.
