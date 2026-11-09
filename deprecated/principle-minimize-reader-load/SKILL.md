---
name: principle-minimize-reader-load
description: Reduce the layers and hidden state readers must trace to understand code.
disable-model-invocation: true
---

# Minimize Reader Load

Maintainability is the work a reader must do to understand code. Reduce both the layers a reader must trace to reach an answer and the hidden state a reader must hold in mind.

## Problem It Solves

Code is read longer than it is written. A one-caller wrapper, an adapter that passes through the same arguments, a broad interface that hides little meaning, and widely shared mutable state force unnecessary tracing and memory. A short file with few branches remains difficult when a reader cannot quickly answer `Where does this value come from?` and `What can change it?`.

## How to Apply It

1. **Count the layers to an answer.** Trace functions, modules, and adapters between the review question and its answer. Consider merging structures with one caller or a layer that only passes the same methods and arguments onward.
2. **Check that each layer changes the abstraction.** A layer must hide related complexity or express a distinct responsibility. Remove pass-through layers and design boundaries that hide meaningful decisions with [Deep Module](../principle-deep-module/SKILL.md).
3. **Shrink state scope.** Prefer returns to mutation, local variables to fields, fields to module state, and module state to global state. Find whether one value can be derived instead of synchronizing two values.
4. **Express invariants once at a boundary.** Put validation, conversion, and guarantees at the boundary with [Boundary Discipline](../principle-boundary-discipline/SKILL.md), so each consumer does not have to infer or recheck them. Make names and types reveal the condition.
5. **Compare reader cost before adding.** Check whether a new layer or state reduces more understanding work elsewhere than it creates. Use [Laziness Protocol](../principle-laziness-protocol/SKILL.md) to consider a solution with fewer concepts and less code.

## Stop When

A new reader can answer `Where does this value come from?` and `What can change it?` within 30 seconds, and you can explain the complexity or responsibility each remaining layer and state represents. Verify preserved behavior with [Closed Working Loop](../principle-closed-working-loop/SKILL.md).

## Avoid

- Keeping a one-caller wrapper or one-implementation adapter only for a possible future.
- Calling a layer an abstraction when it passes the same methods and arguments onward.
- Synchronizing state by updating it in many places.
- Making every consumer recheck the same conditions and invariants.
- Judging reader cost from file length, branch count, or layer count alone.
