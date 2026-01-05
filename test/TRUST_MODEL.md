# TRUST_MODEL.md  
**NeuroGrid Core Protocol**

**Status:** Active  
**Phase:** Hackathon Deployment → Mainnet-Forward Compatible  
**Last Updated:** 2026-01-02  

---

## 1. Purpose

This document defines the **trust, accountability, and enforcement model** of the NeuroGrid protocol.

NeuroGrid is designed as a **deterministic, auditable, and governance-controlled system** for decentralized computation, scientific artifacts, and AI coordination.

Trust is **not implicit**.  
Trust is **earned, observed, and enforced through verifiable signals**.

---

## 2. Core Trust Philosophy

NeuroGrid follows four foundational principles:

1. **Determinism over Assumption**  
   All trust signals are derived from objective, on-chain events.

2. **Telemetry before Punishment**  
   The system records behavior first; enforcement is a governance decision.

3. **Explicit Roles, Explicit Power**  
   Every permission is role-bound. No hidden authority exists.

4. **Upgradeable without Rewriting Trust**  
   Trust rules persist across upgrades and chains.

---

## 3. Trust Domains

Trust in NeuroGrid is segmented into **five independent domains**:

| Domain | Description |
|------|-------------|
| Kernel Trust | Protocol state correctness |
| Validator Trust | Execution honesty |
| Compute Trust | Task fulfillment integrity |
| Governance Trust | Proposal legitimacy |
| Artifact Trust | Scientific reproducibility |

Failure in one domain does **not** automatically compromise others.

---

## 4. Actors & Trust Assumptions

### 4.1 Kernel (NeuroGridKernel)

- **Assumption:** Kernel enforces invariant state transitions
- **Trust Basis:** Deterministic guards, access control, telemetry
- **Failure Mode:** Halts state changes, emits fault telemetry

Kernel does **not** self-repair. Governance intervenes.

---

### 4.2 Validators

Validators are permissioned participants who attest to:

- Compute execution
- Artifact validity
- Protocol actions

**Trust Basis:**
- Deterministic event emissions
- Registry status
- Historical fault telemetry

Validators are **observable**, not trusted by default.

---

### 4.3 Compute Nodes

Compute nodes execute registered workloads.

**Trust Basis:**
- Registry authorization
- Artifact submission integrity
- Telemetry emission consistency

Compute results are **verifiable outputs**, not assumed truths.

---

### 4.4 Governance (NeuroDAO + ProposalExecutor)

Governance is the **only entity allowed to impose consequences**.

**Trust Basis:**
- On-chain voting
- Quorum enforcement
- Deterministic execution windows

Governance actions are **fully auditable and replay-safe**.

---

### 4.5 Artifacts

Artifacts represent scientific outputs, AI results, or datasets.

**Trust Basis:**
- Immutable registry entries
- Validator attestations
- Contextual hashes

Artifacts are **tamper-evident**, not mutable.

---

## 5. Deterministic Fault Model

All protocol failures are classified via **canonical fault codes**.

### Severity Classes

| Severity | Meaning |
|--------|--------|
| NONE | Informational |
| SOFT | Recoverable / Reviewable |
| HARD | Objective violation |

Faults are **telemetry events**, not punishments.

---

### Fault Telemetry Event Schema

FaultEmitted(
bytes32 indexed faultCode,
address indexed actor,
address indexed target,
uint8 severity,
uint256 timestamp,
bytes32 contextHash
)


This schema is **chain-agnostic and indexer-safe**.

---

## 6. Slashing & Enforcement Model

### Hackathon Phase (Current)

- ❌ No automatic slashing
- ✅ Telemetry-only enforcement
- ✅ Governance observation enabled

This prevents irreversible economic harm during early deployment.

---

### Post-Hackathon (Planned)

Governance may introduce:

- Validator slashing
- Compute reputation decay
- Token-based penalties

**Only via proposal + execution.**  
No hidden enforcement paths exist.

---

## 7. Role-Based Trust Enforcement

### Key Roles

| Role | Authority |
|----|-----------|
| DEFAULT_ADMIN_ROLE | Emergency + upgrades |
| GRID_ADMIN_ROLE | Registry & validator management |
| GOVERNANCE_ROLE | Proposal execution |
| VALIDATOR_ROLE | Attestation authority |

No role bypasses telemetry.

---

## 8. Upgrade Safety (UUPS)

All core contracts:

- Preserve storage layout
- Preserve telemetry schemas
- Preserve fault code taxonomy

Upgrades **cannot erase trust history**.

---

## 9. Cross-Chain Trust Compatibility

Trust signals are:

- Event-based
- Deterministic
- Non-chain-specific

This enables future BNB ↔ ETH mirroring without reinterpretation.

---

## 10. Non-Goals (Explicit)

NeuroGrid does **not**:

- Trust off-chain promises
- Apply probabilistic trust scoring
- Auto-slash during hackathon
- Use opaque oracles for enforcement

---

## 11. Audit & Forensics Guarantees

The protocol guarantees:

- Immutable behavior history
- Actor-attributed fault records
- Replay-safe governance actions
- Deterministic blame attribution

Every decision is reconstructible from on-chain data alone.

---

## 12. Summary

NeuroGrid treats trust as a **measurable system property**, not a belief.

- Telemetry records truth
- Governance decides consequence
- Determinism prevents abuse
- Transparency enables legitimacy

This model scales from hackathon deployment to real-world scientific infrastructure without conceptual rewrites.

---

**End of TRUST_MODEL.md**
