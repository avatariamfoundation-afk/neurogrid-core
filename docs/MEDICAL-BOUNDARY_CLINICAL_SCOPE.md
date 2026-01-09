# MEDICAL-BOUNDARY_CLINICAL_SCOPE.md`

---

## 1. Purpose of This Document

This document explicitly defines the **medical, clinical, and regulatory boundaries** of NeuroGrid.

It exists to ensure:
- Clear separation between **infrastructure** and **medical practice**
- Unambiguous communication to judges, auditors, and regulators
- Zero risk of misrepresentation as a medical device or clinical system

This document is **deliberately conservative**.

---

## 2. Core Positioning Statement

**NeuroGrid is not a medical system.**  
**NeuroGrid does not provide diagnosis, treatment, or clinical decision-making.**

NeuroGrid is a **deterministic coordination and provenance infrastructure** that may be *used by* compliant medical systems, but never *acts as one*.

---

## 3. Explicit Non-Clinical Scope

NeuroGrid **does NOT**:

- Diagnose disease
- Predict medical outcomes
- Recommend treatments
- Interpret patient data
- Generate clinical insights
- Replace medical professionals
- Interface directly with patients
- Make autonomous decisions of medical relevance

Any implication otherwise is incorrect.

---

## 4. What NeuroGrid Actually Does

NeuroGrid provides **infrastructure primitives** only:

| Capability | Description |
|-----------|-------------|
| Deterministic coordination | Ensures repeatable execution ordering |
| Artifact provenance | Tracks lineage of generated artifacts |
| Telemetry enforcement | Requires structured execution reporting |
| Fault accountability | Applies deterministic fault codes |
| Governance | Controls upgrades and policies |

All outputs are **technical artifacts**, not medical conclusions.

---

## 5. Medical Boundary Definition

The **medical boundary** exists at the interface between:

- **External medical systems** (out of scope)
- **NeuroGrid infrastructure** (in scope)

[ Clinical Systems ]
│
│ (data / models / workflows)
▼
──────────────────────────────
MEDICAL BOUNDARY LINE
──────────────────────────────
▲
│ (deterministic coordination,
│ telemetry, provenance)
│
[ NeuroGrid Infrastructure ]


Crossing this boundary requires **external compliance**, not NeuroGrid logic.

---

## 6. Responsibility Allocation

| Domain | Responsibility |
|------|----------------|
| Clinical decisions | External systems |
| Medical compliance | External operators |
| Model validation | External auditors |
| Patient safety | External practitioners |
| Infrastructure determinism | NeuroGrid |
| Provenance tracking | NeuroGrid |
| Fault accountability | NeuroGrid |

NeuroGrid **never assumes clinical responsibility**.

---

## 7. Data Handling Position

NeuroGrid:
- Does not require patient-identifiable data
- Does not process raw medical records
- Does not enforce medical schemas
- Does not assume HIPAA / GDPR compliance by default

If medical data is used:
- It is **external**
- It is **abstracted**
- It is **the responsibility of the integrating system**

---

## 8. Regulatory Classification Intent

NeuroGrid is intended to be classified as:

- **Non-medical software infrastructure**
- **General-purpose distributed coordination system**
- **Provenance and telemetry framework**

It is **not intended** to be:
- A medical device
- Clinical decision support
- Diagnostic software
- Therapeutic platform

---

## 9. Future Medical Integration (Out of Scope)

Future systems may:
- Build compliant medical workflows
- Use NeuroGrid for auditability
- Leverage deterministic execution for traceability

Those systems:
- Are separate products
- Require independent certification
- Are not implied by this repository

---

## 10. Judge & Auditor Assurance

This declaration exists to ensure:
- No regulatory ambiguity
- No clinical overreach
- No misinterpretation of system intent

NeuroGrid is intentionally **boring**, **defensive**, and **bounded**.

That is by design.

---

## 11. Final Declaration

NeuroGrid:
- Is infrastructure
- Is deterministic
- Is auditable
- Is non-clinical

Any medical use occurs **outside** this system.

---

**Document Status:** Final  
**Applies To:** NeuroGrid Core  
**Audience:** Judges, Auditors, Regulators  

