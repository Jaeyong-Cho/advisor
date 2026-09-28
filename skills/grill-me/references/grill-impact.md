# Grill Impact Level and Uncertainty

## Decision authority

Do not ask the user to choose a questioning mode by default. The user sets direction, outcomes, and rules; the worker owns methods inside those boundaries. Ask only when the answer could change an outcome, scope, safety or authorized boundary, or requires the user's judgment. Explicitly honor a request for more interactive discussion or manual approval.

Mark the impact and uncertainty of questions you do ask. Impact indicates how widely a decision affects the system, not who owns it.

### Low Level (0)
- Constant value
- Configuration value
- Local variable / internal logic
- Function implementation
- Single-module internal structure
- Single-module data structure
- Easy to change things... 

### Medium Level (1)
- Multi-function logic
- Multi-file change
- Module internal behavior
- Module interface
- Shared data structure

### High Level (2)
- Database schema
- Cross-service logic
- API contract
- Data migration
- External library / service integration
- Protocol / file format
- Deployment architecture
- System architecture
- Cross-system contract
- Platform / OS / hardware dependency
- External organization / vendor contract
- Production-scale breaking change
- Hard to change things...

## Uncertainty
**MUST MARK** each question's uncertainty.
- High: Can not known until execute and see the result
- Low: Obviously know the expected result

For every High uncertainty question, recommend the smallest experiment (spike, prototype, one-off script, manual probe) that would turn it into Low uncertainty before committing to an answer.

## Action

- For factual uncertainty, inspect existing evidence or run the smallest safe experiment before asking the user. Record an assumption and a check for non-blocking uncertainty.
- For method choices within the goal and rules, make a reasoned choice and verify its result, regardless of impact level. Surface trade-offs when they affect the outcome or future rule ownership.
- For user-owned choices or a conflict with the existing rules, ask a focused question with the evidence, options, and consequences. Keep the existing rule in force while the owner decides. Continue independent work when possible.
- For high uncertainty, recommend the smallest safe experiment that could resolve it before committing to an answer.
