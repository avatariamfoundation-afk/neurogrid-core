# SECURITY_ASSUMPTIONS.md  
**NeuroGrid Core – Security Model, Assumptions & Threat Boundaries**

**Status:** Hackathon-Ready / Production-Aligned  
**Scope:** neurogrid-core  
**Applies To:** Smart Contracts, Governance, Telemetry, Registries  
**Last Updated:** 2026-01-02  

---

## 1. Purpose

This document defines the **explicit security assumptions** under which NeuroGrid Core operates.

It exists to:
- Make trust boundaries explicit
- Prevent false security claims
- Enable judge, auditor, and contributor review
- Separate *hackathon-safe mode* from *production mode*

No system is secure without assumptions.  
This document states them clearly.

---

## 2. Security Posture Summary

| Layer | Status |
|----|----|
| Smart Contracts | Deterministic, unaudited |
| Governance | Role-based, bounded |
| Slashing | Defined, disabled in hackathon |
| Telemetry | Deterministic, non-authoritative |
| Cross-Chain | Read-only, no trust delegation |
| Funds at Risk | None (testnet only) |

---

## 3. Threat Model Overview

NeuroGrid assumes the presence of:

- Malicious validators
- Faulty compute nodes
- Adversarial transaction ordering (MEV)
- Partial network failure
- Byzantine off-chain actors

NeuroGrid **does not assume**:
- Honest majority at all times
- Trusted off-chain compute
- Trusted cross-chain relayers
- Trusted UI or frontend clients

---

## 4. Explicit Trust Assumptions

### 4.1 Blockchain Layer (BNB Chain)

Assumed:
- Consensus finality is correct
- Reorgs are bounded
- Chain does not censor transactions permanently

Not assumed:
- Zero MEV
- Zero downtime
- Infinite throughput

---

### 4.2 Smart Contracts

Assumed:
- Solidity compiler behaves as specified
- Deployed bytecode matches source
- Roles are configured correctly at deployment

Not assumed:
- Absence of undiscovered bugs
- Formal verification completeness
- Audit-level guarantees

---

### 4.3 Governance Actors

Assumed:
- DAO roles are known and explicit
- Admin actions are observable on-chain

Not assumed:
- Governance participants are benevolent
- Proposals are economically rational
- No collusion exists

---

### 4.4 Validators & Compute Nodes

Assumed:
- Nodes may behave incorrectly
- Nodes may go offline
- Nodes may attempt fraud

Not assumed:
- Honest execution
- Accurate off-chain computation
- Correct telemetry reporting

Mitigation is achieved through:
- Deterministic fault codes
- Telemetry correlation
- Slashing policy (disabled in hackathon)

---

## 5. Hackathon Safety Mode (Current)

During hackathon deployment:

- ❌ Slashing is disabled
- ❌ Funds are not escrowed
- ❌ Upgrades are locked
- ❌ Governance execution is bounded
- ✅ Telemetry is enabled
- ✅ Fault detection is active
- ✅ Deterministic events are emitted

This prevents irreversible damage while preserving observability.

---

## 6. Deterministic Telemetry Assumptions

Telemetry events are assumed to be:

- Deterministic
- Immutable once emitted
- Observable by anyone

Telemetry is **not assumed** to be:
- Truth
- Final judgment
- Automatic punishment

Telemetry feeds *decision systems*, not enforcement directly.

---

## 7. Slashing & Penalty Model Assumptions

Slashing is defined but **inactive**.

Assumed for future activation:
- Slashing decisions require on-chain confirmation
- Fault codes are deterministic
- Governance can halt slashing

Not assumed:
- Automatic correctness
- Zero false positives
- Fully autonomous punishment

---

## 8. Cross-Chain Security Assumptions

Cross-chain telemetry is:

- Read-only
- Non-authoritative
- Non-binding

Assumed:
- External chains may lie
- Relayers may fail
- Data may be delayed

Therefore:
- No funds move cross-chain
- No governance executes cross-chain
- No trust is delegated externally

---

## 9. Key Management Assumptions

Assumed:
- Deployer keys are controlled securely
- Admin keys are not reused
- Keys can be rotated

Not assumed:
- Key holders are infallible
- Compromise will never occur

Mitigation:
- Role separation
- Minimal privileges
- Governance-gated upgrades

---

## 10. Upgrade & Mutation Assumptions

Assumed:
- Contracts are immutable during hackathon
- Upgrades require explicit governance approval post-hackathon

Not assumed:
- Emergency upgrades without process
- Silent logic mutation

---

## 11. Data & Privacy Assumptions

NeuroGrid Core assumes:
- No raw medical data is stored on-chain
- No PII is processed at protocol level

Therefore:
- HIPAA/GDPR/LGPD risks are minimized
- Compliance enforcement is off-chain

On-chain data is limited to:
- Hashes
- Metadata
- Receipts
- Deterministic identifiers

---

## 12. Out-of-Scope Threats

Explicitly out of scope:

- UI phishing attacks
- Social engineering
- Wallet malware
- Off-chain data poisoning
- Regulatory enforcement

These are acknowledged but not mitigated at protocol level.

---

## 13. Security Maturity Roadmap

Post-hackathon security hardening includes:

1. Professional smart contract audit
2. Formal verification of core logic
3. Slashing activation
4. Upgrade governance enablement
5. Bug bounty program
6. Multi-sig admin controls

---

## 14. Final Assertion

NeuroGrid Core makes **no unverifiable security claims**.

All guarantees are:
- Explicit
- Observable
- Bounded
- Upgradeable only by governance

This document is a **contract with reviewers, judges, and users**.

---

**End of SECURITY_ASSUMPTIONS.md**

