# COST_CEILING_POLICY.md
## NeuroGrid / DeSci / MedIntel Stack

**Status:** Enforced  
**Scope:** CORE · DeSci Registry · MedIntel Interfaces  
**Objective:** Ensure predictable, bounded operational costs across all on-chain and hybrid workflows.

---

## 1. Policy Purpose

This policy defines **hard and soft cost ceilings** for on-chain interactions, registry writes, validations, and anchoring operations within the NeuroGrid ecosystem.

The intent is to:
- Prevent gas-cost explosions
- Protect long-term protocol sustainability
- Enable deterministic budgeting for validators, researchers, and integrators
- Enforce architectural discipline (off-chain first, on-chain minimal)

---

## 2. Cost Philosophy (Non-Negotiable)

1. **On-chain is for proofs, not payloads**
2. **Batch > single write**
3. **Off-chain compute, on-chain verification**
4. **No unbounded loops**
5. **No dynamic storage growth without ceilings**

Any component violating these principles is considered **non-compliant**.

---

## 3. Cost Domains

### 3.1 On-Chain (Ethereum / EVM)

Applies to:
- NeuroGridCore.sol
- ValidatorModule.sol
- ReputationModule.sol
- IncentiveModule.sol
- GovernanceAdapter.sol

### 3.2 Hybrid (DeSci Registry)

Applies to:
- Registry anchors
- Validation attestations
- Research trace commitments

### 3.3 Off-Chain (MedIntel)

Applies to:
- Indexers
- Read mirrors
- UI/UX interfaces
- Analytics pipelines

---

## 4. Hard Cost Ceilings (Enforced)

### 4.1 Per-Transaction Gas Ceiling

| Operation Type                | Max Gas (Hard Cap) |
|------------------------------|--------------------|
| Registry Anchor Write        | 120,000 gas        |
| Validator Attestation        | 90,000 gas         |
| Reputation Update            | 70,000 gas         |
| Incentive Distribution       | 100,000 gas        |
| Governance Signal Commit     | 110,000 gas        |

**Transactions exceeding these limits MUST revert.**

---

### 4.2 Storage Constraints

- No dynamic arrays without explicit max length
- No per-user growing storage structures
- No on-chain JSON, blobs, or metadata

**Allowed storage:**
- `bytes32`
- `uint256`
- fixed-size structs
- mappings with bounded write paths

---

## 5. Soft Cost Ceilings (Adaptive)

Soft ceilings trigger **warnings, batching, or deferrals**, not reverts.

| Layer        | Threshold Trigger                          |
|-------------|---------------------------------------------|
| DeSci       | > 50 anchors/hour → batch required          |
| Validators  | > 500 attestations/day → aggregation mode   |
| Governance  | > 20 proposals/week → snapshot-only voting  |
| MedIntel UI | > 1s response → cached read-mirror enforced |

---

## 6. Mandatory Cost Controls

### 6.1 Batch Anchoring

- Registry writes MUST support batch submission
- Single-anchor writes allowed only for:
  - Critical governance events
  - Emergency revocations

Batch roots MUST be:
- Merkle roots
- ZK commitments
- Deterministic hash trees

---

### 6.2 Read-Mirror Enforcement

- UI and APIs MUST read from indexers
- Direct chain reads limited to:
  - Proof verification
  - State confirmation
  - Dispute resolution

---

### 6.3 Cost-Aware Module Design

Each contract/module MUST expose:
- `estimateCost()` (off-chain helper)
- deterministic gas paths
- no unbounded external calls

---

## 7. Monitoring & Enforcement

### 7.1 Automated Checks

- CI gas profiling required
- Any PR increasing gas >10% MUST be justified
- Storage diff checks mandatory

### 7.2 Governance Overrides

Governance MAY temporarily lift soft ceilings but:
- NEVER hard ceilings
- NEVER storage constraints
- NEVER loop bounds

---

## 8. Failure Modes & Responses

| Violation Type        | Response                          |
|----------------------|-----------------------------------|
| Hard ceiling breach  | Transaction revert                |
| Soft ceiling breach  | Batch / defer / throttle          |
| Repeated violations  | Validator penalty / slashing      |
| UI bypassing mirror  | Access blocked                    |

---

## 9. Compliance Declaration

All NeuroGrid, DeSci, and MedIntel components are considered **non-production** until this policy is satisfied.

Non-compliant modules MUST NOT be deployed.

---

## 10. Final Constraint

> **If cost cannot be predicted, the design is invalid.**

This policy supersedes all informal optimization guidance.

---
