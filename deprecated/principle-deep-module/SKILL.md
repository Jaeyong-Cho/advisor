---
name: principle-deep-module
description: Design module interfaces that hide meaningful complexity and reduce caller burden.
disable-model-invocation: true
---

# Deep Module

Design modules that minimize what callers must know while taking responsibility for enough functionality and related complexity behind a simple interface.

## Problem It Solves

If callers must know internal processing order and state after a module is separated, complexity has only moved to the call site. A deep module provides substantial functionality and hides implementation detail relative to the cost of understanding and using its interface. Its interface includes behavior and constraints the caller must know, not only function signatures.

Depth is not code length or call-stack depth. The measure is how little knowledge a caller needs to complete necessary work.

## How to Apply It

1. **Define the necessary responsibility.** When redesigning in Chill Mode, use [First Principle Redesign](../principle-first-principle-redesign/SKILL.md) to establish the purpose, required behavior, and constraints before choosing a boundary.
2. **Inspect caller burden.** At real use sites, identify required concepts, configuration, call order, state, and error handling. Do not judge interface simplicity by method or parameter counts alone.
3. **Keep related knowledge and decisions inside.** Put details callers need not decide, such as data structures and processing strategies, inside the module. Reconsider the boundary when multiple callers handle the same internal knowledge.
4. **Make common use simple.** Do not demand unnecessary preparation or configuration for frequent operations. Let only callers with special needs know about special options.
5. **Compare call sites and change impact.** Check whether callers know less after the design, and whether internal changes require call-site changes. Reconsider pass-through layers that add little functionality or information hiding.

State externally observable failure conditions and side effects in the contract. [Understand Through Abstraction](../principle-understand-through-abstraction/SKILL.md) explains a subject from its external contract inward; Deep Module designs a subject that callers can use through that contract.

## Stop When

Representative callers can complete necessary work from the contract without reading implementation or coordinating internal state, and related implementation changes remain inside the module. Verify preserved behavior through [Closed Working Loop](../principle-closed-working-loop/SKILL.md) after structural changes.

## Avoid

- Collecting unrelated responsibilities just to create a deep module.
- Treating smaller files and functions as a design improvement by themselves.
- Creating implicit state or hidden call order to reduce parameters.
- Hiding important failures or side effects behind a superficially simple interface.
- Being satisfied with hiding complexity when it can be reduced.
