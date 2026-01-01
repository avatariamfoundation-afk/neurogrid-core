# NeuroGrid Interface Boundaries

## Core Principle
All systems interact with NeuroGrid through explicit interfaces only.
No direct state mutation outside approved contracts is permitted.

## Allowed
- Read registry state
- Submit anchored records via approved modules
- Submit validations via ValidatorModule

## Forbidden
- Direct Core writes
- Cross-module implicit calls
- Hidden side effects

## Enforcement
- Interfaces define all external touchpoints
- Contracts must reference interfaces, not implementations
- Any bypass is a critical violation

