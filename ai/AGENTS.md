# AGENTS.md

These are my global development preferences.

Project-specific instructions and established project conventions always take precedence.

## Core principles

- Aim for production-quality code.
- Optimize for correctness, clarity, maintainability, and simplicity.
- Prefer the smallest change that fully solves the problem.
- Understand the existing code before modifying it.
- Preserve existing behavior unless a change is intentional.
- Follow established project patterns before introducing new abstractions.
- Avoid speculative generalization and premature abstraction.
- Prefer explicit, boring, predictable code over clever code.

## Code quality

Write code that is easy to understand, review, test, debug, and maintain.

Prefer:

- clear naming
- small, focused units of code
- explicit ownership and lifetime
- strong invariants
- well-defined interfaces
- minimal coupling
- high cohesion
- deterministic behavior
- simple control flow

Avoid:

- unnecessary complexity
- hidden side effects
- duplicated logic
- excessive indirection
- overly generic abstractions
- global mutable state
- surprising behavior
- unnecessary dependencies

Do not optimize for fewer lines of code.

Optimize for fewer opportunities for bugs.

## Correctness

Treat edge cases and failure paths as first-class concerns.

Consider:

- invalid input
- boundary conditions
- resource exhaustion
- partial failure
- cleanup paths
- lifetime issues
- concurrency
- undefined behavior
- integer and size conversions
- error propagation

Do not silently ignore errors unless this is intentional and justified.

Do not rely on undocumented behavior.

If an assumption affects correctness, make it explicit.

## Design

Before adding a new abstraction, check whether the existing design already provides the right place for the change.

Prefer local solutions when the problem is local.

Introduce abstractions only when they reduce real complexity.

Keep interfaces as small as practical.

Avoid making unrelated parts of the system depend on each other.

When practical, separate new logic from side effects and express it as pure functions with explicit inputs and outputs.

Prefer designs where core behavior can be tested without filesystem access, network access, hardware, global state, timing dependencies, or other external effects.

Keep side-effecting code thin and push decision-making and transformation logic into easily testable units.

Do not force pure functions where they make the design less clear or require artificial abstractions.

Do not refactor unrelated code unless it is necessary for the requested change.

## Dependencies

Do not add a dependency unless it provides clear value.

Before adding one, consider:

- whether existing code already solves the problem
- maintenance cost
- compatibility
- security
- runtime cost
- build complexity
- long-term ownership

Prefer standard library and existing project facilities when they are sufficient.

## Performance

Do not optimize blindly.

Prioritize correctness and clarity unless performance requirements justify otherwise.

When performance matters:

- identify the actual bottleneck
- reason about complexity
- avoid unnecessary allocations and copies
- consider latency and memory usage
- measure when practical

Prefer predictable performance over fragile micro-optimizations.

## Concurrency

Treat concurrent code as high risk.

Consider:

- data races
- deadlocks
- lock ordering
- object lifetime
- cancellation
- shutdown behavior
- atomic semantics

Prefer the simplest synchronization model that is correct.

## Security

Treat external input as untrusted.

Be careful around:

- parsers
- buffer sizes
- integer arithmetic
- filesystem paths
- command execution
- serialization
- authentication and authorization
- privilege boundaries

Never expose credentials, private keys, tokens, or secrets.

## Testing and verification

A change is not complete until it has been reasonably verified.

New behavior should normally come with tests.

When adding functionality:

- structure the implementation so that core logic is easy to test
- prefer unit tests for pure or deterministic logic
- test important edge cases and failure paths
- add regression tests for bugs when practical
- avoid tests that depend unnecessarily on timing, global state, external services, or implementation details

Run the most relevant available checks, such as:

- tests
- compilation
- static analysis
- linters
- sanitizers
- integration checks

Add or update tests when behavior changes or when they materially reduce regression risk.

Do not skip useful tests merely because the implementation currently makes testing inconvenient; consider improving the design to make the behavior testable.

Never claim something was tested if it was not.

If verification is incomplete, clearly state what remains unverified.

## Debugging

Prefer evidence over speculation.

Understand the root cause before applying a fix whenever practical.

Do not hide symptoms with workarounds unless the tradeoff is intentional and explicit.

## Git and changes

- Do not modify unrelated files.
- Preserve existing user changes.
- Avoid broad formatting changes unrelated to the task.
- Inspect the final diff before finishing.
- Remove temporary debugging code.
- Do not commit, push, rewrite history, or force-push unless explicitly requested.

## Communication

Keep explanations concise, technical, and precise.

For non-trivial changes, explain:

- what was wrong
- what changed
- why this approach was chosen
- important tradeoffs
- how the change was verified

Do not present guesses as facts.

## Definition of done

Before finishing:

1. Inspect the final diff.
2. Check for unnecessary complexity.
3. Check error and edge cases.
4. Check resource and lifetime handling.
5. Check whether new logic is cleanly separated from side effects where practical.
6. Ensure new behavior has appropriate tests.
7. Run relevant verification.
8. Confirm unrelated behavior was not changed.
9. State any remaining risks, assumptions, or unverified areas.
