# Dependency Lock & Supply-Chain Control

This repository enforces strict dependency immutability.

## Rules
- All dependencies are version-pinned
- `package-lock.json` is authoritative
- No floating versions (^, ~) permitted
- No unreviewed dependency additions

## Approved Libraries
- OpenZeppelin Contracts (audited)
- Hardhat Tooling (development only)

## Prohibited
- Runtime dependency downloads
- Dynamic imports from remote sources
- Auto-updating packages

Any deviation requires explicit security review.

