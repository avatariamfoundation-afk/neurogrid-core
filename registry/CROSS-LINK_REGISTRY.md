# CROSS-LINK_REGISTRY.md  
**Core Cross-Domain Reference & Integrity Anchor Specification**

---

## 1. Purpose

This document defines the **Core Cross-Link Registry** role within the NeuroGrid Core system.

Its function is to act as the **canonical integrity anchor** that cryptographically references and validates cross-domain linkages between:

- Core smart contracts
- DeSci governance artifacts
- MedIntel clinical AI artifacts

The Core registry **does not interpret meaning** — it anchors **existence, linkage, and authority boundaries**.

---

## 2. Scope

The Core Cross-Link Registry applies to:

- Hash references between repositories
- Authority-bound linkage assertions
- Governance-to-clinical trace anchors
- Emergency state linkage markers
- Audit reconstruction primitives

It does **not**:
- Store documents
- Execute governance logic
- Influence clinical workflows
- Enforce off-chain decisions

---

## 3. Design Mandate

Core acts as a **neutral integrity layer** with the following constraints:

- Hash-only storage
- Append-only records
- Deterministic reference resolution
- Domain separation preservation
- Minimal on-chain surface area

Core is a **ledger of truth**, not a system of judgment.

---

## 4. Cross-Link Record Definition

Each Core cross-link record must include:

- Cross-link ID
- Source domain identifier (CORE / DESCI / MEDINTEL)
- Source artifact hash or registry ID
- Target domain identifier
- Target artifact hash or registry ID
- Link classification
- Timestamp
- Authorizing contract or role

All fields are mandatory.

---

## 5. Link Classification Types

Permitted classifications include:

- GOVERNANCE_REFERENCE
- CLINICAL_ACKNOWLEDGMENT
- SAFETY_ESCALATION
- EMERGENCY_MARKER
- AUDIT_TRACE
- REGULATORY_REFERENCE

Undefined classifications are rejected.

---

## 6. Submission Flow

1. Off-chain artifacts finalized
2. Domain registry anchoring completed
3. Cross-link payload assembled
4. Core contract validates structure
5. Hash recorded on-chain
6. Event emitted for audit indexing

Core does not validate semantic correctness.

---

## 7. Immutability & Supersession

- Cross-link records are immutable
- Supersession requires a new record
- Superseding links must reference prior IDs
- Historical graph must remain intact

---

## 8. Authority Boundaries

Core enforces **who may write**, not **what the link means**.

Write permissions are restricted to:
- Authorized governance contracts
- Safety Council contracts
- Emergency override contracts

No clinical system may write directly.

---

## 9. Emergency Handling

During declared emergencies:
- Emergency cross-links may be written
- Must include emergency classification
- Automatically flagged for post-event review
- Cannot be deleted or hidden

---

## 10. Read Access & Transparency

- All cross-links are publicly readable
- Event logs support off-chain indexing
- External auditors may reconstruct linkage graphs
- No anonymization is performed at Core level

---

## 11. Regulatory Alignment

The Core Cross-Link Registry supports:

- EU AI Act traceability requirements
- FDA audit trail expectations
- ISO 37301 compliance evidence
- DAO legal defensibility

It provides **proof of linkage**, not justification.

---

## 12. Prohibited Functions

Core must never:
- Execute governance votes
- Gate clinical execution
- Interpret AI outputs
- Encode medical logic

---

## 13. Audit & Retention

All records:
- Are immutable and timestamped
- Persist for the lifetime of the chain
- Are admissible as integrity evidence
- Support independent verification

---

### Status  
**Active – Binding Core Infrastructure Reference**

