# INDEXER_AND_READ_MIRROR_SPECIFICATION.md
**NeuroGrid CORE · DeSci · MedIntel**

---

## 1. Purpose

This specification defines the **Indexer and Read-Mirror architecture** required to ensure NeuroGrid remains scalable, performant, and usable without increasing on-chain load.

The indexer/read-mirror layer is **mandatory infrastructure**, not an optimization.

Its role is to:
- Decouple read performance from on-chain constraints
- Enable non-expert usability
- Preserve immutable auditability
- Prevent direct on-chain querying at scale

---

## 2. Scope

This specification applies to:

- NeuroGrid Core registry reads
- Cross-link traversal
- Validation history queries
- Emergency state monitoring
- DeSci and MedIntel consumption layers
- UI dashboards (clinical, research, public)

All high-frequency reads MUST use a read-mirror.

---

## 3. Architectural Principle

> **Write on-chain once. Read off-chain forever.**

The blockchain is the source of truth, not the source of performance.

---
## 4. Cost-Aware Read Enforcement

Read-mirrors and indexers are mandatory to enforce on-chain cost ceilings.

Direct contract reads are restricted to:
- Proof verification
- State confirmation
- Dispute resolution

All UI, API, and analytics access MUST route through indexers in
accordance with:

→ `COST_CEILING_POLICY.md`

Any interface bypassing the read-mirror layer is considered
non-compliant and MUST be blocked.

---

## 5. Indexer Responsibilities

The indexer MUST:

- Subscribe to all Core events:
  - `RegistryAnchored`
  - `CrossLinkAnchored`
  - `EmergencyDeclared`
  - `EmergencyCleared`
- Ingest events in real time
- Preserve original ordering and timestamps
- Store raw event payloads immutably
- Reconstruct full registry and cross-link state

The indexer MUST NOT:
- Interpret clinical meaning
- Modify event content
- Filter events by business logic

---

## 6. Read-Mirror Responsibilities

The read-mirror MUST:

- Expose queryable views of:
  - Registry records
  - Cross-links
  - Validation anchors
  - Emergency status
- Support indexed queries by:
  - Domain
  - Record type
  - Timestamp
  - Emergency flag
- Serve UI and API clients exclusively

Direct UI access to on-chain contracts is prohibited.

---

## 7. Data Model Requirements

The read-mirror data model MUST include:

- Original on-chain identifiers
- Transaction hash
- Block number
- Event timestamp
- Submitting address
- Full event payload
- Off-chain batch references (where applicable)

Loss of any of the above invalidates audit fidelity.

---

## 8. Consistency & Integrity Guarantees

The indexer MUST provide:

- Deterministic replay from genesis
- Idempotent ingestion
- Checkpointing and recovery
- Chain re-org handling

Any divergence between read-mirror and chain state must be detectable and correctable.

---

## 9. Latency & Performance Targets

- Event ingestion latency: ≤ 5 seconds (best effort)
- Read query latency (p95): ≤ 300 ms
- Availability target: ≥ 99.9%

Performance tuning must never sacrifice correctness.

---

## 10. Emergency Handling

During `emergencyActive == true`:

- Emergency events must be flagged immediately
- Read-mirror must surface emergency state prominently
- No suppression or delay is permitted

Emergency visibility is a safety requirement.

---

## 11. Access Control & Segmentation

The read-mirror MUST support:

- Role-based access (clinician / researcher / admin / public)
- Data segmentation by domain
- Read-only guarantees

The indexer itself must operate with minimal privileges.

---

## 12. Audit & Verification

Auditors must be able to:

- Trace any read-mirror record back to:
  - Event
  - Transaction
  - Block
- Verify no records are missing
- Reconstruct registry state independently

Audit access must not require production credentials.

---

## 13. Prohibited Practices

The following are forbidden:

- Writing derived data back on-chain
- Mutating indexed events
- Dropping historical records
- Caching without provenance
- Serving UI data directly from RPC calls

---

## 14. Relationship to Other Standards

This specification must be read with:

- SCALABILITY_ASSURANCE_ADDENDUM.md
- BATCH_ANCHORING_STANDARD.md
- DESCI_REGISTRY_MECHANICS.md
- PUBLIC_TRANSPARENCY_DASHBOARD_SPEC.md

---

## Status

**Active · Binding · Required Infrastructure**

