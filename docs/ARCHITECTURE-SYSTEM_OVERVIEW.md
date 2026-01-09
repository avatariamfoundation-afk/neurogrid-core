# ARCHITECTURE-SYSTEM_OVERVIEW.md`

---

## 1. Purpose of This Document

This document provides a **system-level architectural overview** of NeuroGrid.  
It is written to give judges, auditors, and technical reviewers a clear mental model of:

- What components exist
- How they interact
- Where trust boundaries are enforced
- Why the system is deterministic by design

This is **not** an implementation guide and **not** a clinical architecture.

---

## 2. System Design Principles

NeuroGrid is architected around the following non-negotiable principles:

1. **Determinism over performance**
2. **Explicit trust boundaries**
3. **Auditable execution paths**
4. **Governance before automation**
5. **Infrastructure ≠ medical decision-making**

---

## 3. High-Level System View

NeuroGrid is composed of three tightly scoped layers:

┌─────────────────────────────────────┐
│ Governance Layer │
│ (DAO, Policies, Slashing Rules) │
└─────────────────────────────────────┘
↓
┌─────────────────────────────────────┐
│ Deterministic Coordination │
│ (Kernel, Registries, Executors) │
└─────────────────────────────────────┘
↓
┌─────────────────────────────────────┐
│ Off-Chain Compute & Telemetry │
│ (Compute Nodes, Artifacts, Metrics) │
└─────────────────────────────────────┘


No step may be skipped.  
No implicit success is allowed.

---

## 7. Trust Boundaries

| Boundary | Description |
|--------|------------|
| On-chain ↔ Off-chain | Enforced via signatures and telemetry |
| Compute ↔ Validator | Enforced via fault codes |
| Validator ↔ DAO | Enforced via governance rules |
| DAO ↔ System | Enforced via execution delays |

---

## 8. Determinism Guarantees

NeuroGrid guarantees determinism at the **coordination level**, not at the model level.

What is deterministic:
- Registration
- Execution ordering
- Artifact recording
- Slashing outcomes

What is intentionally out-of-scope:
- Model weights
- Clinical interpretation
- Real-time medical decisions

---

## 9. Security Model Alignment

This architecture assumes:
- Honest-majority validators **are not required**
- Faults will occur
- Actors may behave adversarially

The system is designed to **contain damage**, not assume good behavior.

---

## 10. Regulatory Posture

NeuroGrid is:
- Infrastructure-only
- Non-clinical
- Non-diagnostic

It is designed to **support** compliant medical systems, not replace them.

---

## 11. Architectural Finality

This architecture is:
- Minimal
- Defensive
- Extensible only through governance

It is intentionally conservative to support:
- Audits
- Hackathon review
- Long-term medical-grade evolution

---

**Document Status:** Final  
**Scope:** Core NeuroGrid System  
**Audience:** Judges, Auditors, Technical Reviewers  
