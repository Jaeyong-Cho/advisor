# Abstraction Levels (L1 / L2 / L3)

Every function or method sits at one of three levels. Code reads top-to-bottom as a description of the system when each function stays at one level and calls downward — never upward. "Downward" doesn't mean exactly one hop: `L1 → L1 → L2` (an orchestration composed of orchestrations) and `L1 → L3` (skipping L2 when there's genuinely no business rule to add) are both normal — see Dependency direction below.

This file is self-contained: table, dependency direction, agent questions, smells, then the full 15-rule set with Good/Bad code examples below.

L2/L3 examples illustrate internal implementations. Apply the project's private or internal visibility convention when using them; exposing a capability requires an L1 contract under Great Code.

**Related docs, different scale of the same idea:** `meta-pattern.md`'s Abstractness axis (use cases / domain logic / infrastructure) is this same vertical split, but at the system/module-decomposition scale rather than per-function — read it when the question is "does this need a new module or service," not "what level is this function." `deep-modules.md` is how to shape the interface at an L1→L2 or L2→L3 boundary once it exists — small interface, hidden complexity, dependencies accepted not created.

## Levels recurse across scale

L1/L2/L3 is not a fixed, system-wide label — it's relative to whatever unit you're currently decomposing (a function inside a file, a method inside a class, a file inside a service, a service inside the system), and the same three-level split repeats one scale down whenever you step inside a unit.

A DB service, seen from the rest of the system, is L3 (a mechanism the rest of the system calls). Step inside that service and it has its own L1 (its public entry-point files/API — "what does this service do for a caller"), L2 (its internal domain rules — e.g. connection-pool policy, retry/migration ordering), and L3 (the code that actually touches the driver/socket). Same one scale further down: an L3 file can itself contain an L1 function (its public entry point) orchestrating L2 helper functions down to the L3 functions that make the real driver calls.

The **never call upward** rule applies independently at each scale — a service's internal L3 code never calls its own L2, same as a function's L3 never calls its own L2 — but crossing a scale boundary (an L1 file inside an externally-L3 service, being called by another service) isn't a violation of that rule; it's just a different scale. Before classifying, name the unit you're looking at and apply the Three-level test relative to *that unit's own callers* — don't classify a function as L1 globally just because the service containing it happens to be L3 from the outside.

**The point of recursing is to keep each scale from mixing, not to excuse mixing.** Rule 7 (Keep One Abstraction Level Per Function) still holds at every scale: if a "DB service" file has its top-level entry point issuing raw driver calls right next to its orchestration logic, that's the same L1-leaking-L3 smell as inside a single function — the fix is the same too, decompose that file/service into its own L1→L2→L3 units instead of leaving them interleaved in one place. Recursion is not a loophole for "it's fine to mix here because this is a lower scale" — every scale gets its own clean split, or it doesn't recurse, it just mixes.

| Level | Answers | Typical examples | DDD equivalent |
|-------|---------|-------------------|-----------------|
| **L1 — Intent** | What does this do, from the caller's view? | Public APIs, use cases, app services, orchestration methods | Application Service |
| **L2 — Domain** | What should happen per business rules? | Validation, calculation, policy, state transition | Entity / Domain Service |
| **L3 — Mechanism** | How is it technically done? | DB, HTTP, SDK, filesystem, serialization | Infrastructure / Gateway |

## Dependency direction

```
L1 (intent) → L2 (domain) → L3 (mechanism)
```

The rule is **never call upward** — L3 never calls L2 or L1, L2 never calls L1 — not "always exactly one hop down." Two shapes both satisfy it and are both normal:

- **Same-level composition** — an L1 function calling another L1 function (`L1 → L1 → L2`) is fine when the outer one is an orchestration of orchestrations; same for L2 calling L2.
- **Level skip** — an L1 function calling L3 directly (`L1 → L3`) is fine when there's genuinely no business rule between the intent and the mechanism, and the direct call still reads as intent. Skip only because there's truly nothing for L2 to add — not to avoid writing a domain rule that should exist (that's the Missing L2 smell below, a different thing).

L2 may depend on an L3 *interface* (e.g. `PaymentGateway`), never a concrete L3 implementation (`StripeClient`) — that keeps L2 swappable and testable without infrastructure. A dependency pointing the other way (L3 or L2 code deciding business outcomes) is a design error.

## Exposed functions are L1

For Great Code, every entry point and public/exported function is L1 at the unit being examined. Apply exposure before classifying internal behavior. Public domain operations retain meaningful names and contracts while delegating their rules to internal L2 functions; mechanisms belong in internal L3 functions. Private orchestration helpers can still be L1. Do not change required visibility merely to change a function's classification or length limit.

## Agent questions

- **One-sentence test** — can this function be explained in one clear sentence without "and"? If explaining it needs a list of unrelated steps, it mixes levels — split it.
- **Three-level test**, in order: Is it an entry point or public/exported function → L1. Otherwise, does it describe overall workflow → L1; a business rule/state transition → L2; or a technical mechanism → L3?
- **Decomposition check** (for a new or changed L1 flow): which L2 domain functions does this orchestration need — and for each, is there truly no business rule involved, in which case it calls L3 directly instead? Which L3 mechanism functions do those L2 functions (or the direct-L3 steps) need? Do they already exist, or must they be created? Naming this before writing the L1 function is what tells a real level-skip apart from the Missing L2 smell.

## Testing by level

Test primarily through caller-facing interfaces and their concrete implementations. Choose the smallest interface that exposes the changed behavior and failure risk; do not assign a test to every function or abstraction level. Verify contract outcomes rather than internal structure or call sequencing.

- **L1** — exercise the exposed operation and assert its observable outcomes, including meaningful rejection or failure cases. Run real internal L2/L3 logic where practical, isolating external boundaries when needed. Use integration or E2E scope when the workflow or wiring requires it; do not assert internal call sequencing.
- **L2** — verify rules, calculations, validation, and transitions through the owning module's interface by default. Add a focused internal rule test only when interface tests cannot practically verify a consequential rule or regression. Do not change visibility solely for testing.
- **L3** — exercise the concrete adapter through its infrastructure contract. Use an integration or contract test with real infrastructure when correctness depends on database, HTTP, filesystem, SDK, framework, or serialization behavior. Tests of a mocked interface do not verify its implementation.

## Smells

| Smell | What it looks like | Level |
|---|---|---|
| L1 leaking L3 | Orchestration method makes the HTTP/DB/SDK call itself instead of delegating | L1 |
| L2 leaking L3 | Business rule mixed with an HTTP/DB call in the same function | L2 |
| Missing L2 | L1 skips straight to L3 to avoid writing a business rule that actually exists (validation, calculation, policy) — a justified skip has no rule to write in the first place | L1→L3 |
| Mechanical extraction | Private function split out only because a block was long, not because it names a concept (see `deep-modules.md`) | any |
| Domain rule hidden as plumbing | A meaningful business rule buried in a `_helper`/`_process` name instead of a domain-revealing one | L2 |
| Shallow L1 | Orchestration re-implements domain logic inline instead of delegating to L2 | L1 |
| Technical name at L1/L2 | `execute_step()`, `handle_data()`, `process_request()` instead of `checkout()`, `calculate_discount()` (see `naming.md`) | L1/L2 |

---

## Full Rule Set (Good/Bad Examples)

Design code around three levels of abstraction:

- **L1 — Intent / Public Contract**
- **L2 — Domain / Business Behavior**
- **L3 — Implementation / Mechanism**

The primary goal is to make code readable from top to bottom as a description of what the system does, while hiding unnecessary implementation details behind meaningful abstractions.

---

## 1. L1 — Intent / Public Contract

### Purpose

L1 expresses **what the system or component does** from the perspective of its caller.

Typical examples:

- Public APIs
- Use cases
- Application services
- Public entry points
- Interfaces / Protocols
- High-level orchestration methods

Example:

```python
class OrderService:

    def checkout(self, order):
        self.validate_order(order)
        self.calculate_total(order)
        self.process_payment(order)
        self.complete_order(order)
```

A developer should be able to understand the overall behavior of `checkout()` without reading its implementation details.

### Rules

- L1 should read like a natural-language description of the system's behavior.
- Express high-level intent and business flow.
- Use meaningful domain-oriented function names.
- Avoid database, HTTP, JSON, file-system, SDK, or framework details.
- Do not expose unnecessary implementation details.
- Prefer calling L2 operations rather than implementing detailed business rules directly.
- Do not directly call low-level infrastructure APIs.
- The sequence of L1 operations should communicate the main workflow clearly.

#### Good

```python
def checkout(order):
    validate_order(order)
    calculate_total(order)
    process_payment(order)
    complete_order(order)
```

#### Bad

```python
def checkout(order):
    response = requests.post("/payment", json=order)
    cursor.execute("INSERT INTO orders ...")
    ...
```

The second version exposes implementation details and makes the high-level behavior harder to understand.

---

## 2. L2 — Domain / Business Behavior

### Purpose

L2 expresses **what the system should do according to domain rules**.

Typical examples:

- Domain logic
- Business rules
- Validation
- Calculations
- Policies
- State transitions
- Domain behavior
- Meaningful internal operations

Example:

```python
class Order:

    def calculate_total(self):
        subtotal = self.calculate_subtotal()
        discount = self.calculate_discount()
        shipping = self.calculate_shipping()

        return subtotal - discount + shipping
```

### Rules

- Express domain concepts and business rules.
- Use domain terminology rather than technical terminology.
- Conditional logic and loops are allowed when they represent business behavior.
- Keep business rules independent from infrastructure details.
- Do not directly depend on database, HTTP, file-system, or framework details when avoidable.
- L2 may depend on L3 abstractions to perform technical operations.
- Each function should represent one meaningful domain concept or responsibility.

#### Good

```python
def calculate_discount(order):
    if order.customer.is_vip:
        return order.total * 0.1

    return 0
```

The rule is about the business domain, so it belongs to L2.

#### Bad

```python
def calculate_discount(order):
    response = requests.get("/customers/" + order.customer_id)
    ...
```

The business rule is now mixed with HTTP implementation details.

---

## 3. L3 — Implementation / Mechanism

### Purpose

L3 expresses **how something is technically performed**.

Typical examples:

- Database access
- HTTP requests
- External APIs
- File-system operations
- Network communication
- Serialization / deserialization
- ORM operations
- SDK calls
- Framework-specific code
- Operating-system interactions

Example:

```python
class StripePaymentGateway:

    def pay(self, payment):
        payload = self._create_payload(payment)

        response = self._client.post(
            "/payments",
            json=payload
        )

        return self._parse_response(response)
```

### Rules

- Focus on technical mechanisms.
- Hide infrastructure details behind meaningful interfaces.
- Do not contain business decisions unless strictly required by the technical mechanism.
- Changes to infrastructure, libraries, or external services should be isolated here.
- L3 should expose a simple interface to higher-level code.
- Do not allow technical details to leak upward into L1.

---

## 4. Classify Exposure Before Internal Behavior

An entry point or public/exported function is always L1 under this skill's convention. Make its body express the caller's operation and keep detailed domain rules or mechanisms in internal L2/L3 functions. A function is not sufficiently abstract merely because its body has been labeled L1.

For internal functions, classify by behavior: orchestration is L1, domain rules are L2, and mechanisms are L3. Visibility alone does not make every private function L2 or L3.

Place exposed L1 functions before internal functions in a file, after required imports and declarations. Within a class, place exposed methods before internal methods while preserving required declaration and initialization order. See the skill entrypoint for the exact function limits and measurement rules.

---

## 5. Public API Should Reveal Intent

When a class exposes a public method, prefer exposing a meaningful concept rather than an implementation mechanism.

**Prefer**

```python
order.checkout()
order.cancel()
order.calculate_total()
```

**Avoid**

```python
order.execute_step()
order.update_database()
order.send_http_request()
order.process_data()
```

Public APIs should communicate **what the object means or does**, not how it performs the operation.

---

## 6. Interfaces Define Contracts, Not Mechanisms

Interfaces / Protocols should generally describe **capabilities and intent**, not implementation details.

**Good**

```python
class PaymentGateway(Protocol):

    def pay(self, payment) -> PaymentResult:
        ...
```

The interface says: "Something capable of processing a payment." It does not say whether the implementation uses Stripe, PayPal, HTTP, or a database.

**Implementation**

```python
class StripePaymentGateway(PaymentGateway):

    def pay(self, payment):
        ...
```

The concrete implementation contains the technical mechanism.

The dependency structure should look like:

```text
Application / Domain
        │
        ▼
PaymentGateway
   (contract)
        │
        ▼
StripePaymentGateway
   (implementation)
        │
        ▼
Stripe SDK / HTTP
```

---

## 7. Keep One Abstraction Level Per Function

A function should not mix unrelated abstraction levels.

**Bad**

```python
def checkout(order):
    validate_order(order)
    calculate_total(order)

    response = requests.post(
        "/payment",
        json=order
    )

    database.execute(...)
```

This mixes business behavior, HTTP implementation, and database implementation.

**Good**

```python
def checkout(order):
    validate_order(order)
    calculate_total(order)
    process_payment(order)
    save_order(order)
```

Technical details are delegated downward.

---

## 8. Prefer a Clear Dependency Direction

The rule is **never call upward** — not "always exactly one hop down." The preferred conceptual direction is:

```text
L1 — Intent
 ↓
L2 — Domain / Business Behavior
 ↓
L3 — Implementation / Mechanism
```

but two shapes both satisfy the rule and are both normal, not exceptions:

- **Same-level composition** — an L1 function calling another L1 function (`L1 → L1 → L2`), an orchestration composed of orchestrations. Same for L2 calling L2.
- **Level skip** — an L1 function calling L3 directly (`L1 → L3`), when there's genuinely no business rule between the intent and the mechanism and the direct call still reads as intent. Skip only because there's truly nothing for L2 to add — not to avoid writing a domain rule that should exist. Skipping *that* rule, not the absence of one, is the smell (Missing L2, in `abstraction-levels.md`'s smells table).

What's never acceptable, regardless of shape: L3 calling L2 or L1, or L2 calling L1 — a dependency pointing toward more abstract code from more mechanical code.

Higher-level code should also depend on **abstractions**, not necessarily concrete L3 implementations.

```text
             L1
              │
              ▼
             L2
              │
              ▼
       PaymentGateway
          (interface)
              ▲
              │
             L3
              │
       StripePaymentGateway
```

The important principle: higher-level code should not need to know which concrete technology performs the operation.

---

## 9. Use the One-Sentence Test

Every meaningful function should be explainable in one clear sentence.

```python
calculate_discount(order)
```

can be explained as: "Calculate the discount according to the applicable business rules." Good.

But if explaining a function requires: "It validates the order, retrieves customer information, calculates the discount, saves the result, and sends an event..." then the function probably contains multiple responsibilities or abstraction levels. Consider decomposing it.

---

## 10. Extract Functions Based on Meaning, Not Size

Do not create functions merely because a block of code is long. Create a function when the code represents a **meaningful concept, responsibility, or operation**.

Ask: **"Does giving this code a name make the program easier to understand?"**

If yes, extraction is likely useful. If no, keeping the code inline may be clearer.

A three-line function can be valuable:

```python
calculate_shipping(order)
```

while a thirty-line function may still be appropriate if it represents one coherent concept.

---

## 11. Prefer Intent-Revealing Names

Function names should describe **what the operation means**, rather than how it is implemented.

**Prefer**

```python
validate_order()
calculate_total()
process_payment()
save_order()
notify_customer()
```

**Avoid**

```python
run_calculation()
execute_step()
handle_data()
process_request()
do_operation()
```

Names should help the reader understand the system without opening the function immediately.

---

## 12. Expose Domain Operations through L1 Contracts

Operations such as `Order.calculate_total`, `Order.can_cancel`, and `Order.cancel` may remain public because callers need those domain capabilities. Under this skill, their exposed functions are L1. Keep the detailed calculation, eligibility policy, or state-transition rule in internal L2 functions with meaningful domain names.

Judge the exposed contract by what callers need to know and the internal implementation by the rules it owns. Preserve behavior and avoid adding layers solely to satisfy a metric.

---

## 13. Hide Mechanics, Not Meaning

Internal methods may own domain rules or technical mechanisms. Their names must preserve domain meaning even when the implementation is private. Expose the needed capability through an L1 contract rather than hiding it from callers.

**Good**

```python
def _build_payment_payload(payment):
    ...

def _parse_payment_response(response):
    ...

def _create_database_record(order):
    ...
```

These are implementation details.

**Be careful with**

```python
def _calculate_discount(order):
    ...
```

If discount calculation is an important domain concept, hiding it merely because it is implemented as a private method may make the domain model less expressive.

The question is not "Is this private?" The question is "Is this a meaningful concept that callers or developers should be able to understand?"

---

## 14. Use the Three-Level Decision Test

When creating or modifying a function, ask these questions in order:

1. Is this an entry point or public/exported function? → **L1**; keep its implementation at the level of the caller's operation.
2. For an internal function, does this describe the overall purpose or workflow? → **L1**
3. Does this internal function express a business rule, domain concept, or state transition? → **L2**
4. Does this internal function describe a technical mechanism or interaction with infrastructure? → **L3**

---

## 15. Optimize for Progressive Disclosure

The codebase should allow developers to understand the system progressively. The preferred reading experience is:

```text
L1
"What does the system do?"
        ↓
L2
"What business rules make it work?"
        ↓
L3
"How is it technically implemented?"
```

A developer should not have to read database queries, HTTP requests, or framework code to understand the main business flow. The developer should be able to **drill down only when more detail is needed**.

---

## Core Principle

The primary design goal is: **make the code read like a description of the system at the appropriate level of abstraction.**

Use:

```text
L1 → Intent
L2 → Business Meaning
L3 → Technical Mechanism
```

with these conventions:

```text
Entry point / Public / Exported → L1 contract
Internal → L1, L2, or L3 according to behavior
Interface / Implementation → Contract vs Mechanism
```

Meet the function limits in the skill entrypoint while preserving **clear intent → clear business behavior → isolated implementation details**. Do not satisfy the limits through meaningless extraction or hidden behavior changes.
