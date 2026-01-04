# TRUST_MODEL.md
## NeuroGrid Trust, Security, and Assurance Model

**Status**: Active  
**Scope**: NeuroGrid Core · MedIntel · DeSci  
**Audience**: Judges · Auditors · Contributors · Integrators  

---

## 1. Purpose

This document defines the **explicit trust assumptions, guarantees, and boundaries** of the NeuroGrid system.

NeuroGrid is designed to operate in **hostile, adversarial, and permissionless environments** while preserving:

- Scientific integrity  
- Clinical safety boundaries  
- Deterministic auditability  
- Minimal trust assumptions  

This trust model is **foundational** and applies across all repositories.

---

## 2. Core Trust Philosophy

NeuroGrid follows a **zero-trust-by-default** model.

> No component is trusted unless explicitly verified, constrained, and auditable.

### Explicitly NOT Trusted by Default
- Off-chain compute results  
- AI model outputs  
- External APIs  
- Oracles  
- Contributors  
- Validators  
- Governance participants  

### Explicitly Trusted Anchors
- Immutable on-chain records  
- Deterministic smart contract execution  
- Cryptographic hashes and signatures  
- Public event logs  

---

## 3. Trust Zones

NeuroGrid is divided into **four trust zones**:

### Zone A — On-Chain Kernel (High Trust)
**Components**
- NeuroGridKernel
- ArtifactRegistry
- ValidatorManager
- ABSToken
- Governance contracts

**Guarantees**
- Deterministic execution
- Immutable state transitions
- Transparent audit trail
- Enforced access control

**Threat Model**
- Smart contract bugs
- Governance abuse (mitigated by design constraints)

---

### Zone B — Off-Chain Compute (Low Trust)
**Components**
- Compute nodes
- AI inference engines
- MedIntel pipelines
- External analytics

**Guarantees**
- NONE by default

**Controls**
- Hash-based result anchoring
- ComputeRegistry lifecycle enforcement
- Validator attestation requirements

Off-chain compute **cannot mutate on-chain truth**.

---

### Zone C — Validation & Review (Conditional Trust)
**Components**
- Validators
- Peer reviewers
- Research auditors

**Guarantees**
- Attestations are logged, not enforced
- Disagreement is preserved

**Controls**
- Validator reputation
- Multi-validator requirements
- Immutable validation history

---

### Zone D — User & Governance Layer (Bounded Trust)
**Components**
- DAO participants
- Proposal authors
- Token holders

**Guarantees**
- Governance is transparent, not infallible

**Controls**
- Explicit proposal scope
- Time delays
- Execution separation (ProposalExecutor)

---

## 4. Trust Assumptions (Explicit)

The system assumes:

1. **Blockchain liveness**
   - BNB Chain continues producing blocks

2. **Cryptographic soundness**
   - Hash functions remain collision-resistant

3. **Public verifiability**
   - Anyone can independently audit events

The system does **NOT** assume:
- Honest compute providers
- Correct AI outputs
- Benevolent governance
- Trusted data sources

---

## 5. Attack Surface & Mitigations

| Threat | Mitigation |
|------|-----------|
| Fake AI results | Hash-only anchoring + validator review |
| Malicious compute nodes | Registry lifecycle + suspension |
| Data poisoning | Provenance + validation artifacts |
| Governance capture | Separated execution + scope limits |
| Silent failures | Mandatory event emission |
| Data exfiltration | No raw data on-chain |

---

## 6. Clinical & Scientific Safety Boundary

NeuroGrid enforces a **hard boundary**:

> The system provides **evidence and insight**, never decisions.

### Explicitly Prohibited
- Autonomous clinical decisions
- Automatic treatment recommendations
- Silent model updates
- Hidden confidence manipulation

All outputs are **advisory**.

---

## 7. Trust Decay & Revocation

Trust is **revocable**.

- Compute nodes can be suspended
- Validators can be discredited
- Proposals can be invalidated
- Results remain immutable but **contextually deprecated**

History is never erased.

---

## 8. Auditability Guarantee

Every trust-relevant action is:

- Logged on-chain **or**
- Cryptographically anchored **or**
- Cross-linked via registry references

Black-box operation is structurally impossible.

---

## 9. Hackathon Alignment

For hackathon purposes:

- No centralized trust shortcuts
- No privileged bypasses
- No hidden admin keys

Judges can independently verify:
- Contract logic
- Event history
- Registry state
- Governance constraints

---

## 10. Future Hardening (Post-Hackathon)

Planned enhancements:
- Slashing mechanisms
- ZK-verified computation
- Decentralized validator markets
- Formal verification

These are **additive**, not required for current trust guarantees.

---

## 11. Summary

NeuroGrid’s trust model is:

- Minimal
- Explicit
- Adversary-aware
- Clinically conservative
- Scientifically reproducible

Trust is **earned through evidence**, not assumed by design.

---

**Document Integrity**
- Immutable reference document
- Changes require governance approval
- Versioned alongside core contracts
