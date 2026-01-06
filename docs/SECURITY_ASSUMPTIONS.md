# SECURITY_ASSUMPTIONS.md

Repository: neurogrid-core  
Canonical Location: /docs/SECURITY_ASSUMPTIONS.md

---

## 1. Purpose

This document defines the **explicit security assumptions** under which the NeuroGrid protocol is designed, deployed, and evaluated.

These assumptions are critical for:
- Auditor review
- Hackathon judging
- Governance clarity
- Real-world deployment readiness

NeuroGrid **does not claim absolute security**. It claims **well-scoped, transparent, and enforceable security boundaries**.

---

## 2. Security Philosophy

NeuroGrid follows a **Deterministic Defense Model**:

- Failures are expected
- Faults are classified, not hidden
- Enforcement is governed, not hardcoded
- Security is observable via telemetry

The protocol assumes **bounded adversaries**, not omnipotent attackers.

---

## 3. Trust Boundaries

### 3.1 Trusted Components

The following are assumed to behave correctly unless explicitly faulted:

- Ethereum / BNB Chain consensus
- EVM execution correctness
- Solidity compiler correctness (v0.8.19)
- Cryptographic primitives (ECDSA, Keccak256)

---

### 3.2 Semi-Trusted Components

These components are trusted **conditionally** and monitored:

- Validators
- Compute Nodes
- DAO Proposal Executors
- Cross-chain relayers

Misbehavior is expected and mitigated via slashing.

---

### 3.3 Untrusted Components

These components are assumed to be adversarial:

- End users
- External data sources
- Off-chain computation environments
- Network transport layers

---

## 4. Adversary Model

NeuroGrid assumes adversaries may:

- Control one or more compute nodes
- Attempt false computation submission
- Attempt validator collusion (minority)
- Attempt replay or delay attacks
- Attempt governance spam

NeuroGrid assumes adversaries **cannot**:

- Break cryptography
- Control majority consensus
- Forge on-chain events
- Bypass EVM execution rules

---

## 5. Governance Assumptions

The protocol assumes:

- DAO governance token distribution is non-captured
- No single entity controls quorum
- Emergency governance actions are observable
- Proposal execution is deterministic

Governance capture is explicitly classified as a **CRITICAL FAULT**.

---

## 6. Validator Assumptions

Validators are assumed to:

- Be economically rational
- Prefer rewards over slashing
- Act independently

Validators are **not** assumed to be honest by default.

Fault-based enforcement replaces trust.

---

## 7. Compute Node Assumptions

Compute nodes are assumed to:

- Occasionally fail
- Occasionally behave lazily
- Potentially attempt malicious outputs

All compute outputs require:
- Hash verification
- Validator attestation
- Deterministic fault attribution

---

## 8. Slashing Assumptions

Slashing is assumed to:

- Be economically meaningful
- Be governed, not automatic
- Be applied after fault verification

Slashing logic is **not embedded directly in core execution paths** to prevent cascading failures.

---

## 9. Upgradeability Assumptions

NeuroGrid uses **UUPS upgradeability**.

Assumptions:
- Upgrade authority is controlled by governance
- Upgrade paths are auditable
- No silent upgrades are permitted

Upgrade abuse is classified as a **CRITICAL SECURITY FAULT**.

---

## 10. Cross-Chain Assumptions

Cross-chain telemetry assumes:

- Message delivery may be delayed
- Message ordering may vary
- Duplicate messages may occur

All cross-chain data must be:
- Idempotent
- Deterministically verifiable
- Non-authoritative by default

---

## 11. Telemetry Assumptions

Telemetry is assumed to be:

- Public
- Observable
- Non-private by default

Privacy is enforced at the data layer, not telemetry.

Missing telemetry is treated as a **FAULT**, not a silent failure.

---

## 12. Out-of-Scope Threats

NeuroGrid explicitly does NOT protect against:

- Global network shutdowns
- Consensus-level attacks
- Zero-day EVM exploits
- Compromised developer environments
- Social engineering of governance members

---

## 13. Audit Readiness Statement

These assumptions are:

- Explicit
- Reviewable
- Challengeable

Auditors and judges are encouraged to evaluate NeuroGrid **within these declared bounds**, not hypothetical omnipotent models.

---

## 14. Status

State: Active  
Version: v1.0  
Applies To: Core Protocol  
Change Control: DAO Governance

---
