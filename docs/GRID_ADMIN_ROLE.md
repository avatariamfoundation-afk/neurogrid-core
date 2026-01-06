# GRID_ADMIN_ROLE.md

## NeuroGrid — Grid Administrator Role Specification

**Status:** ACTIVE  
**Applies To:** neurogrid-core  
**Scope:** Operational control, safety enforcement, and infrastructure governance  
**Audience:** Core maintainers, auditors, hackathon judges, future operators

---

## 1. Purpose of the Grid Admin Role

The **Grid Admin Role** exists to ensure **operational safety, availability, and integrity** of the NeuroGrid system without granting unilateral power over governance, funds, or research outcomes.

This role is **infrastructure-focused**, not political or economic.

It is designed to:
- Maintain uptime
- Enforce safety controls
- Respond to faults and emergencies
- Coordinate compute grid integrity
- Protect users and researchers from systemic failures

---

## 2. Role Separation Principle

NeuroGrid enforces **strict separation of powers**:

| Role | Authority Scope |
|----|----|
| DEFAULT_ADMIN | Contract ownership, role assignment |
| GRID_ADMIN | Operational safety & infrastructure |
| DAO / GOVERNANCE | Policy, voting, funding |
| VALIDATORS | Attestation & verification |
| USERS / RESEARCHERS | Interaction & contribution |

**GRID_ADMIN cannot override DAO decisions, mint tokens, or modify governance logic.**

---

## 3. Core Responsibilities

The Grid Admin is responsible for:

### 3.1 Compute Grid Integrity
- Registering and deregistering compute nodes
- Suspending malfunctioning or malicious nodes
- Enforcing compute availability standards
- Coordinating recovery from compute faults

### 3.2 Emergency Controls
- Triggering emergency pause mechanisms
- Flagging critical artifacts or telemetry events
- Temporarily halting unsafe operations
- Initiating deterministic recovery workflows

### 3.3 Telemetry & Fault Enforcement
- Monitoring deterministic telemetry events
- Enforcing fault-code based actions
- Escalating repeated violations to governance
- Coordinating slashing triggers (when applicable)

### 3.4 Operational Safeguards
- Enforcing rate limits
- Preventing system abuse
- Maintaining liveness guarantees
- Supporting audit readiness

---

## 4. Explicit Non-Permissions (Hard Constraints)

The Grid Admin **CANNOT**:

- Modify governance rules
- Execute proposals
- Transfer protocol funds
- Mint or burn tokens
- Alter trust or slashing logic
- Bypass deterministic fault handling
- Override DAO-approved constraints

These limits are **hard-coded by design**.

---

## 5. Smart Contract Authority Surface

The Grid Admin role may be referenced by the following contracts:

- `NeuroGridKernel.sol`
- `ComputeRegistry.sol`
- `ArtifactRegistry.sol`
- `ValidatorManager.sol`

Typical gated functions include:
- `pauseGrid()`
- `resumeGrid()`
- `suspendNode(address)`
- `flagArtifact(bytes32)`
- `acknowledgeFault(uint256)`

All actions emit deterministic events for auditability.

---

## 6. Emergency Mode Behavior

When **Emergency Mode** is activated by the Grid Admin:

- New compute tasks are blocked
- Critical paths remain readable
- No state-destructive actions are allowed
- Governance retains authority to intervene
- A full telemetry snapshot is emitted

Emergency Mode is **temporary by design** and must be exited explicitly.

---

## 7. Audit & Accountability

Every Grid Admin action MUST:
- Emit an on-chain event
- Reference a fault code or operational reason
- Be timestamped
- Be attributable to a specific address

This enables:
- Hackathon validation
- External auditing
- Post-incident forensics
- DAO oversight

---

## 8. Hackathon Context

For the BNB Chain Hackathon:

- Grid Admin may initially be a single multisig or EOA
- All powers are demonstrably constrained
- No centralized control over funds or governance
- Design demonstrates real-world production readiness

This balances **hackathon pragmatism** with **long-term decentralization**.

---

## 9. Upgrade & Transition Strategy

Post-hackathon, the Grid Admin role is expected to transition to:
- DAO-controlled multisig
- Automated policy-based controllers
- Regionally federated operators

No contract redesign is required to support this transition.

---

## 10. Summary

The Grid Admin role is:

- ✅ Operational, not political  
- ✅ Safety-focused, not extractive  
- ✅ Deterministic, auditable, and bounded  
- ✅ Compatible with hackathon constraints  
- ✅ Ready for real-world deployment  

It exists to **protect the grid**, not control it.

---

**Document Version:** 1.0  
**Last Updated:** 2026  
**Project:** NeuroGrid by Aethera BioSync  
