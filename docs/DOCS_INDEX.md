# DOCS_INDEX.md
## NeuroGrid Core — Documentation Index

---

## 1. PURPOSE

This document serves as the **authoritative index** of all documentation contained within the **NeuroGrid Core** repository.

It is designed for:
- Hackathon judges
- Technical reviewers
- Auditors
- Non-developer evaluators

The goal is **fast orientation**, **clear scope**, and **evidence-backed verification**.

---

## 2. HOW TO USE THIS INDEX (JUDGES)

If you have limited time, follow this order:

1. **Final README** → What this system is and is not  
2. **Architecture Overview** → How the system is structured  
3. **Synthetic Demo Docs** → What you can execute and observe  
4. **Safety & Boundary Validation** → Why this is safe  
5. **Execution Logs & Screenshots** → Proof it runs  

Each document is intentionally short, scoped, and non-duplicative.

---

## 3. CORE ORIENTATION DOCUMENTS

| Document | Location | Purpose |
|--------|----------|--------|
| `README.md` | `/` | Primary entry point for judges |
| `CORE_README.md` | `/` | Core system positioning |
| `ARCHITECTURE-SYSTEM_OVERVIEW.md` | `/docs` | System-level design |
| `MEDICAL-BOUNDARY_CLINICAL_SCOPE.md` | `/docs` | Explicit non-clinical scope |
| `ETHICS_SAFETY_CONSTRAINTS.md` | `/docs` | Ethical & safety guarantees |

---

## 4. DEMO & EXECUTION DOCUMENTATION

| Document | Location | Purpose |
|--------|----------|--------|
| `SYNTHETIC-DATARUN_DEMO.md` | `/demo` | Explains runnable demo |
| `DEMO_VALIDATION_EXECUTION_LOG.md` | `/docs` & `/demo` | How screenshots were captured |
| `SAFETY-VALIDATION_CONSOLIDATION-REPORT.md` | `/docs` | Combined safety validation |

---

## 5. SAFETY, BOUNDARIES & CONSTRAINTS

| Document | Location | Purpose |
|--------|----------|--------|
| `SAFETY-BOUNDARY_VALIDATION.md` | `/docs` | System boundary enforcement |
| `DATA-SAFETY_VALIDATION.md` | `/docs` | Synthetic-only data handling |
| `AI-OUTPUT_CONSTRAINTS.md` | `/docs` | Output restriction guarantees |
| `FAILURE_MODES.md` | `/docs` | Fault conditions |
| `FAULT_CODE_MAPPING.md` | `/docs` | Deterministic fault taxonomy |

---

## 6. TRUST, GOVERNANCE & EXECUTION DISCIPLINE

| Document | Location | Purpose |
|--------|----------|--------|
| `TRUST_MODEL.md` | `/docs` | Trust assumptions |
| `SECURITY_MODEL.md` | `/docs` | Security posture |
| `SIGNING_AND_ATTESTATION.md` | `/docs` | Artifact integrity |
| `TEST_MATRIX.md` | `/docs` | Execution & validation cases |
| `TEST_SUITE_ENHANCEMENT.md` | `/docs` | Testing strategy hardening |

---

## 7. API & OBSERVABILITY

| Document | Location | Purpose |
|--------|----------|--------|
| `API_READ_SURFACE.md` | `/docs` | Read-only interaction surface |
| `TELEMETRY.md` | `/docs` | Telemetry model |
| `TELEMETRY_LOG_SUMMARY.md` | `/docs` | Interpreting telemetry output |

---

## 8. JUDGE-FOCUSED MATERIAL

| Document | Location | Purpose |
|--------|----------|--------|
| `JUDGE_ADDENDUM.md` | `/docs` | Funding intent & roadmap |
| `DEPLOYMENT_NOTES.md` | `/docs` | How this runs safely |
| `INTEGRATION_GUIDE.md` | `/docs` | Non-binding future integration |

---

## 9. CI / AUTOMATION

| Artifact | Location | Purpose |
|--------|----------|--------|
| `ci.yml` | `.github/workflows/` | Automated validation |
| GitHub Actions | Repository | Proof of execution discipline |

---

## 10. DESIGN INTENT STATEMENT

NeuroGrid Core documentation is intentionally:
- Modular
- Explicit
- Non-marketing
- Non-ambiguous

This index exists to **respect reviewer time** and **reduce cognitive load**.

---

## 11. STATUS

- All documents listed here are **final**
- READMEs will be **presentation-hardened last**
- No hidden dependencies or unpublished artifacts exist

---

**Document Status:** Final  
**Repository:** neurogrid-core  
**Audience:** Judges, Reviewers, Auditors

