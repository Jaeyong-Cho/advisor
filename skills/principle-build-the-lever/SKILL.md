---
name: principle-build-the-lever
description: Build small rerunnable tools for work that repeats or is expensive to verify manually.
disable-model-invocation: true
---

# Build the Lever

For work that repeats or is difficult to verify, create a rerunnable tool that performs or proves the work instead of doing it by hand.

## Problem It Solves

Manual changes and checks can vary between runs, and a reviewer must repeat the work from the beginning to verify the result. Scripts, codemods, generators, and verification tools repeat work consistently and make results checkable again.

## How to Apply It

1. **Evaluate repetition and verification cost.** Consider a tool when the same change applies to many items or when trust in a single change requires rerunning it. Do not force a tool for a few obvious changes that can be checked at a glance.
2. **Process the first unit manually.** Learn the input, expected output, and exception conditions, then make the smallest useful tool. Use scripts or codemods for edits, generators for repeated files, and rerunnable checks for verification.
3. **Make reruns safe.** A second run with the same input must not produce different results or duplicate changes. Compare the tool's result with the manual result for the first unit.
4. **Put it in the working loop.** Connect the tool's output and verification criteria to [Closed Working Loop](../principle-closed-working-loop/SKILL.md). The tool itself is subject to review and reruns.
5. **Keep the tool with the work.** Save the tool and its usage when a future task or review can reuse it. Use [Laziness Protocol](../principle-laziness-protocol/SKILL.md) to limit the tool to the smallest scope that performs or proves the work.

## Stop When

The tool performs or verifies the target work consistently, reruns safely with the same input, and produces a checkable result. If the work is clearly smaller than the cost of understanding and maintaining a tool, record that judgment and work manually.

## Avoid

- Performing recurring work manually in a different way each time.
- Assuming one successful run proves a tool correct without rerunning or comparing it.
- Building a framework larger than the task and increasing maintenance cost.
- Verifying only the result created by a tool while ignoring its inputs, outputs, and safety.
