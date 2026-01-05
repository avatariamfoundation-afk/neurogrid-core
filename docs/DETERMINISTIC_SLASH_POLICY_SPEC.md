# DETERMINISTIC_SLASHING_POLICY_SPEC.md  
**NeuroGrid Core Protocol**

**Status:** Defined (Hackathon-Safe / Post-Hackathon Enforceable)  
**Applies To:** Validators, Compute Nodes, Governance Actors  
**Chains:** BNB Chain (Primary) | Ethereum & EVM L2s (Future)  
**Last Updated:** 2026-01-02  

---

## 1. Purpose

This document defines the **deterministic slashing model** for NeuroGrid.

Slashing is **rule-based, evidence-backed, and governance-controlled**.  
No subjective judgment. No automated punishment without proof.

---

## 2. Core Principle

> **Slashing is a consequence, not a reaction.**

Telemetry proves behavior.  
Governance authorizes enforcement.  
Execution is deterministic.

---

## 3. Scope of Slashing

Slashing applies to:

- Validators
- Compute Nodes
- Governance Executors (post-hackathon)

It does **not** apply to:
- End users
- Data contributors
- Observers

---

## 4. Deterministic Preconditions

Slashing MAY occur **only if all conditions are met**:

1. A **deterministic fault code** is emitted
2. Fault severity ≥ defined threshold
3. Fault is **verifiable on-chain**
4. Governance proposal passes quorum
5. Slashing window has not expired

If any condition fails → **no slashing**

---

## 5. Canonical Fault Categories

| Category | Description |
|-------|-------------|
| COMPUTE_FAULT | Invalid compute execution |
| VALIDATION_FAULT | Malicious or incorrect validation |
| AVAILABILITY_FAULT | Node downtime or refusal |
| GOVERNANCE_FAULT | Execution deviation |
| TELEMETRY_FAULT | Event suppression or tampering |

Categories are immutable.

---

## 6. Severity Levels

| Level | Name | Slashing Eligible |
|----|-----|------------------|
| 0 | INFO | ❌ |
| 1 | LOW | ❌ |
| 2 | MEDIUM | ⚠️ (Governance Review) |
| 3 | HIGH | ✅ |
| 4 | CRITICAL | ✅ (Expedited) |

Severity is encoded in emitted events and **cannot be altered later**.

---

## 7. Slashing Threshold Matrix

| Fault Category | Severity Required |
|--------------|------------------|
| COMPUTE_FAULT | ≥ 3 |
| VALIDATION_FAULT | ≥ 3 |
| AVAILABILITY_FAULT | ≥ 2 |
| GOVERNANCE_FAULT | ≥ 3 |
| TELEMETRY_FAULT | ≥ 4 |

---

## 8. Slashing Types

### 8.1 Stake Reduction
- Percentage-based
- Capped per epoch

### 8.2 Reward Suspension
- Temporary
- Deterministic duration

### 8.3 Role Revocation
- Validator / Executor removal
- Requires supermajority

### 8.4 Permanent Ban
- Only for CRITICAL telemetry faults
- Requires extended quorum

---

## 9. Evidence Model

Every slashing action must reference:

- Fault event hash
- Emitting contract address
- Timestamp
- Actor address

Evidence must exist **on-chain**.

Off-chain claims are invalid.

---

## 10. Governance Enforcement Flow

1. Fault emitted
2. Telemetry indexed
3. Proposal references fault hash
4. Vote occurs
5. Execution enforced by ProposalExecutor

No shortcuts permitted.

---

## 11. Slashing Windows

| Window | Duration |
|------|----------|
| Proposal Window | 7 days |
| Challenge Window | 3 days |
| Execution Window | 14 days |

Expired windows invalidate slashing eligibility.

---

## 12. Cross-Chain Considerations

- Faults may originate on BNB Chain
- May be mirrored to Ethereum
- Enforcement occurs on **primary chain only**

No automatic cross-chain slashing.

---

## 13. Hackathon Mode (SAFE MODE)

During hackathon:

- Slashing logic is **disabled**
- Telemetry is recorded only
- Governance actions are non-destructive

This guarantees:
- No accidental penalties
- Full audit trail
- Production readiness

---

## 14. Post-Hackathon Activation

Activation requires:

1. Governance proposal
2. Explicit enable flag
3. Public notice period

Slashing is **never silently activated**.

---

## 15. Abuse Prevention

| Risk | Mitigation |
|----|-----------|
| Governance capture | Supermajority |
| False reports | Deterministic evidence |
| Replay attacks | Event hash uniqueness |
| Bridge spoofing | Source validation |

---

## 16. Non-Goals

This policy does **not**:
- Automate punishment
- Depend on off-chain arbitration
- Override governance
- Enforce moral judgment

---

## 17. Final Assertion

Slashing in NeuroGrid is:

- Deterministic
- Auditable
- Governed
- Chain-agnostic
- Scientifically defensible

This ensures **trust without tyranny**.

---

**End of DETERMINISTIC_SLASHING_POLICY_SPEC.md**

