---
name: root-cause
description: Trace a reported symptom backward to an evidence-supported root cause. Use when the user asks why a specific failure or unexpected behavior occurs; investigate with subagents and targeted experiments, or identify the exact observations needed when the causal chain cannot yet be proven.
disable-model-invocation: true
---

# Root Cause

Diagnose the cause of a user-reported symptom. Start at the observed failure and work backward through the states, decisions, and mechanisms that produced it. The deliverable is a causal explanation, not a code change. Read [Fix Root Causes](../principle-fix-root-causes/SKILL.md) and [Understand Through Abstraction](../principle-understand-through-abstraction/SKILL.md) for the relevant diagnostic principles.

## Investigation

1. **Anchor the symptom.** Record the user's observed result, expected result, affected environment and time, and the specific cause they want to identify. Preserve what the user actually observed separately from interpretations. Inspect available code, logs, traces, configuration, and history before asking for facts that can be found locally.
2. **Trace backward.** Find the point where the symptom appears. For each preceding step, identify the value, state, branch, side effect, or contract that produced the next step. Read a function's contract first and its implementation only where the causal link is unclear. Record the evidence for each link, including paths, lines, timestamps, commands, or log identifiers. A possible path through code is not proof that production took that path.
3. **Use subagents for bounded exploration.** Dispatch subagents on read-only investigations of distinct open questions, such as the execution and data path, runtime or environment evidence, and competing explanations or recent changes. Give each agent a specific question and ask for concise findings, evidence locations, counterevidence, and unresolved gaps. Keep the investigation paths separate until their results can be reconciled. If subagents are unavailable, do the same bounded searches directly and state that limit.
4. **Test uncertain links.** When inspection cannot distinguish plausible causes, choose the smallest experiment that can. State the competing hypotheses and what each predicts, run a safe reproduction, read-only query, targeted log check, or temporary isolated experiment, and compare the actual observation with those predictions. Record the input, conditions, output, and limits of the experiment. Do not change production behavior merely to diagnose it.
5. **Judge the cause.** A root-cause claim must explain the complete observed chain, identify the originating condition or violated contract, and survive checks against credible alternatives. Separate root cause, contributing conditions, and the visible symptom. Mark inferred links as hypotheses until an observation or experiment supports them; do not treat correlation, a stack trace, or the newest code change as proof by itself.

## When the chain stops

Do not guess past the last supported link. Explain the traced path from the symptom to that point. Rank the remaining plausible causes by the evidence available, then name the smallest set of observations that would distinguish them. Obtain it through available tools if possible. If only the user can provide it, request a specific log, trace, input, timestamp, state snapshot, or reproduction result; say where to collect it and what different outcomes would imply. Continue independent investigation while waiting for that evidence.

## Result

Explain the path **from the symptom back toward the root cause**, step by step. For each step, state what happened, why it leads to the preceding visible step, and the evidence that supports it. Conclude with one of:

- **Confirmed root cause:** the originating condition, the violated rule or contract, and why it produced the symptom.
- **Unresolved at a named boundary:** the last supported step, the leading hypotheses, and the precise observation needed to distinguish them.

Do not claim a complete diagnosis when a causal link is missing. Recommend a fix or verification path only if the user asks for one; do not implement a fix as part of this skill unless separately requested.
