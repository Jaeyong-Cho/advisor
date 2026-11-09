---
name: principle-code-simplicity
description: Ground goal setting in current evidence across domains. Use when defining or revising any goal, or when explaining or applying the six laws and six grouped practical rules of Code Simplicity to software design.
---

# Code Simplicity

## Goal setting across domains

**Set goals from what you know now.** Identify the present situation, the confirmed need, and the constraints already known. Set an observable outcome that addresses that need. If an unconfirmed assumption would materially change the goal, identify what to verify and revisit the goal when evidence arrives.

For example, if new volunteers are missing their first shift because they cannot find the meeting location, set a goal around helping them find it. Treat the possibility that volunteers also need more training as a separate question to verify.

## Six laws of software design

1. **Purpose of software.** Software exists to help people. Identify who benefits and how.
2. **Equation of software design.** The desirability of a change is proportional to (present value + future value) divided by (implementation effort + maintenance effort). For long-lived software, give recurring maintenance effort more weight than one-time implementation effort.
3. **Law of change.** The longer a program exists, the more likely any part of it will need to change.
4. **Law of defect probability.** The likelihood of introducing a defect increases with the size of the change.
5. **Law of simplicity.** Software is easier to maintain when its individual parts are simpler.
6. **Law of testing.** Confidence in how software behaves depends on how accurately that behavior has been tested.

## Six practical rules

1. **Design from what you know now.** Base design decisions on confirmed requirements and current evidence. If CSV export is the only confirmed format, implement it. When another format is confirmed, use both requirements to decide what behavior should be shared.
2. **Build what is needed and change it in small steps.** Add code when it serves a current need, remove unused code, and generalize only as far as confirmed requirements warrant. Break design improvements into small changes.
3. **Keep each piece of knowledge in one place.** Give a shared rule one authoritative implementation so changing the rule requires fewer edits.
4. **Write for other developers.** Use consistent conventions and names that communicate purpose. Use comments to explain why the code behaves as it does.
5. **Revisit the problem when the design gets complex.** Clarify the problem, inspect the design beneath the visible complexity, and improve the affected parts incrementally. A simple interface can isolate complexity in an external dependency.
6. **Confirm the problem and test the change.** Gather evidence that the problem exists before fixing it, then exercise the behavior you expect to improve.
