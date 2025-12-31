# GAS_PATH_AUDIT_CHECKLIST.md
**Mandatory Pre-Deployment Cost & Execution Audit**

---

## 1. Purpose

This checklist defines the **mandatory gas-path audit requirements** for all
contracts, interfaces, and supporting infrastructure within the
NeuroGrid / DeSci / MedIntel ecosystem.

No component may be deployed, upgraded, or activated unless **every
applicable item in this checklist is satisfied**.

This document enforces:
- Deterministic cost behavior
- Hard ceiling compliance
- Prevention of gas leakage
- Safe scalability under load

---

## 2. Scope of Application

This checklist applies to:

- Core smart contracts
- Registry modules
- Validator modules
- Batch anchoring logic
- Emergency mechanisms
- Indexers and read mirrors
- UI-triggered on-chain interactions
- MedIntel interface bridges

---

## 3. Gas Path Identification (Mandatory)

For each contract or module:

- [ ] All functions capable of on-chain execution are explicitly listed
- [ ] Each function is classified as:
  - READ
  - WRITE
  - BATCH WRITE
  - EMERGENCY WRITE
- [ ] No implicit or hidden state changes exist
- [ ] No fallback or proxy path can mutate state unintentionally

If any gas path is unidentified → **deployment blocked**

---

## 4. Hard Gas Ceiling Verification

For each WRITE or BATCH WRITE function:

- [ ] Maximum gas usage measured under worst-case input
- [ ] Hard gas ceiling defined and documented
- [ ] On-chain enforcement exists (`require(gasUsed <= HARD_CAP)`)
- [ ] Exceeding hard ceiling causes full revert

Absence of enforced hard caps → **critical failure**

---

## 5. Soft Ceiling & Batching Compliance

For operations exceeding soft thresholds:

- [ ] Soft ceiling defined
- [ ] Automatic batching is enforced
- [ ] No user or system override bypasses batching
- [ ] Deferred execution is deterministic and logged

Manual or optional batching → **non-compliant**

---

## 6. Storage Cost Audit

- [ ] No unbounded storage writes
- [ ] No dynamic arrays without explicit limits
- [ ] Hash anchoring used instead of raw data storage
- [ ] External data references are immutable

Any unbounded storage growth → **deployment blocked**

---

## 7. Emergency Path Cost Safety

For emergency functions:

- [ ] Gas usage measured under stress conditions
- [ ] Emergency calls remain below hard ceilings
- [ ] No loops or dynamic writes in emergency paths
- [ ] Emergency activation does NOT trigger cascading writes

Emergency gas spikes → **critical design flaw**

---

## 8. Read Path Optimization

- [ ] UI never reads directly from core contracts
- [ ] Read mirrors/indexers serve all user-facing data
- [ ] On-chain reads limited to verification and dispute resolution
- [ ] No UI-triggered polling of on-chain state

Direct read exposure → **cost leakage risk**

---

## 9. Upgrade & Governance Cost Safety

If upgradeable logic exists:

- [ ] Upgrade execution gas measured
- [ ] Upgrade fits within hard ceiling
- [ ] Rollback path defined and costed
- [ ] Governance execution cannot exceed ceilings

Unbounded upgrade cost → **upgrade prohibited**

---

## 10. Interface-Originated Gas Paths

For every UI or API action:

- [ ] Mapped to exact on-chain function(s)
- [ ] Gas cost documented and user-invisible
- [ ] UI incapable of triggering single-anchor writes
- [ ] All writes routed through batching layer

UI-driven gas ambiguity → **interface non-compliant**

---

## 11. Indexer & Mirror Enforcement

- [ ] Indexers absorb ≥ 95% of read traffic
- [ ] Mirrors are horizontally scalable
- [ ] On-chain reads are rate-limited
- [ ] Fallback read paths are disabled by default

Indexer bypass → **infrastructure breach**

---

## 12. Load & Stress Simulation

- [ ] Simulated peak transaction volume
- [ ] Gas ceilings remain respected under load
- [ ] Batch sizes adapt predictably
- [ ] No transaction starvation or deadlock

Failure under simulated load → **deployment blocked**

---

## 13. Cross-Document Compliance

Confirmed alignment with:

- [ ] COST_CEILING_POLICY.md
- [ ] BATCH_ANCHORING_STANDARD.md
- [ ] INDEXER_READ_MIRROR_SPEC.md
- [ ] DESCI_REGISTRY_MECHANICS.md
- [ ] MEDINTEL_INTERFACE_PREPARATION.md

Any mismatch → **non-compliant**

---

## 14. Final Authorization

Deployment is permitted only if:

- [ ] All checklist items are satisfied
- [ ] Results are archived
- [ ] Audit hash is anchored on-chain
- [ ] Reviewer signatures recorded

---

### Status
**MANDATORY – DEPLOYMENT BLOCKING**

Failure to satisfy any requirement in this checklist
constitutes a **hard stop**.

