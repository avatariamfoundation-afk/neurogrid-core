# SCALABILITY_ASSURANCE_ADDENDUM.md
**NeuroGrid CORE · DeSci · MedIntel**

---

## 1. Purpose

This addendum formally defines the scalability assurances, constraints, and enforcement principles governing the NeuroGrid ecosystem.

Its purpose is to ensure:
- Long-term operational scalability
- Predictable on-chain cost behavior
- Regulatory safety under growth
- Clear separation between technical scaling and clinical risk

This document is **binding** and supersedes any implicit scaling assumptions.

---

## 2. Scope

This addendum applies to:

- NeuroGrid CORE (registry anchor layer)
- DeSci research pipelines
- MedIntel clinical intelligence interfaces
- Governance, audit, and emergency mechanisms

It applies across all deployments (L1, L2, testnets, mirrors).

---

## 3. Scalability Philosophy (Normative)

The NeuroGrid system follows a **Minimal On-Chain, Maximal Off-Chain** model.

On-chain infrastructure exists **only** to:
- Anchor integrity
- Preserve auditability
- Signal authority and emergency state

All computation, analytics, storage, and decision logic must scale **off-chain**.

Any deviation from this philosophy constitutes a design violation.

---

## 4. CORE Scalability Guarantees

NeuroGrid CORE guarantees:

- Registry-only state growth
- Constant-time write operations
- No loops, recursion, or unbounded execution
- No token, payment, or incentive logic
- No autonomous execution pathways

CORE scalability is therefore linear, predictable, and regulator-safe.

CORE **shall never** be used for:
- Data storage
- Research execution
- Clinical decision-making
- Analytics or scoring

---

## 5. Registry Growth Controls

### 5.1 Hash-Only Anchoring (Mandatory)

All registry and cross-link entries must be:
- Cryptographic hashes
- Merkle roots
- Batch digests

Raw data, metadata, or payloads are strictly prohibited on-chain.

### 5.2 Batch Anchoring Requirement (DeSci)

DeSci submissions must aggregate multiple artifacts into:
- Single batch hashes
- Time-windowed digests
- Versioned snapshots

High-frequency single-entry anchoring is prohibited.

---

## 6. Write-Load Management

### 6.1 Domain Responsibilities

- CORE: minimal, low-frequency writes
- DeSci: batched, scheduled anchoring
- MedIntel: exceptional anchoring only (safety-related)

Write amplification must be controlled at the **interface and policy level**, not on-chain.

### 6.2 Emergency Priority

During `emergencyActive == true`:
- Only emergency-relevant anchors are permitted
- Routine research anchoring must pause
- MedIntel may submit safety evidence only

---

## 7. Read Scalability & Indexing

### 7.1 Off-Chain Indexing (Mandatory)

All production systems must rely on:
- Event indexers
- Mirrored databases
- Regulatory audit views

Direct on-chain querying by UI, clinicians, or regulators is prohibited.

### 7.2 Caching for Clinical Use

MedIntel interfaces must:
- Cache read results
- Use snapshot views
- Avoid live-chain dependency during clinical workflows

---

## 8. Cross-Link Scalability Control

Cross-links must be:
- Purpose-driven
- Non-duplicative
- Domain-tagged

Unbounded or combinatorial cross-linking is prohibited.

Cross-links exist for **traceability**, not graph expansion.

---

## 9. Layer-2 & Migration Strategy

### 9.1 L2 Compatibility

CORE contracts are designed to be:
- EVM-compatible
- L2-portable without modification

### 9.2 Migration Principle

Future L2 deployment:
- Does not change logic
- Does not add functionality
- Preserves audit continuity via cross-chain anchoring

Migration is a scalability optimization, not a system upgrade.

---

## 10. Prohibited Scalability Mechanisms

The following are explicitly forbidden:

- On-chain sharding
- On-chain pruning logic
- On-chain pagination
- On-chain analytics
- Autonomous scaling contracts
- Dynamic fee or throughput logic

These mechanisms increase fragility and regulatory exposure.

---

## 11. Compliance & Auditability

Scalability controls must remain:
- Auditable
- Deterministic
- Explainable to regulators

Performance optimizations must never:
- Obscure traceability
- Introduce opacity
- Reduce human oversight

---

## 12. Enforcement

Violations of this addendum constitute:
- Governance breach
- Safety violation
- Audit failure

Corrective action may include:
- Interface suspension
- Registry write revocation
- Emergency declaration

---

## Status

**Active · Binding · Non-Optional**

This addendum is part of the NeuroGrid canonical governance record.

