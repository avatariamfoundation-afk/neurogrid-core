# NeuroGrid Build Rules
**Authoritative Execution & Integrity Standard**

Status: Binding  
Scope: All NeuroGrid repositories (core / medintel / desci)

---

## 1. Purpose

This document defines **non-negotiable build rules** governing the NeuroGrid system.

Its purpose is to ensure:
- Hackathon credibility
- Open-source verifiability
- Regulatory responsibility
- Zero throwaway engineering
- Clean transition to real-world launch

No implementation, feature, or document may violate these rules.

---

## 2. Dual-Track Doctrine

NeuroGrid is built under a **dual-track doctrine**:

- **Hackathon-Valid**
- **Launch-Capable**

Every artifact must satisfy **both**.

Anything built solely for demonstration and not survivable post-hackathon is prohibited.

---

## 3. System Positioning (Mandatory)

NeuroGrid is:

> A decentralized research, validation, and intelligence coordination system for post-operative data.

NeuroGrid is **not**:
- A clinical decision system
- An autonomous medical actor
- A replacement for clinicians

All outputs are **advisory only**.

---

## 4. Compliance Stance

During hackathon phase:

- No claims of certification
- No claims of medical approval
- No real patient deployment

The system operates under **documented readiness**, not false compliance.

Mapped frameworks include:
- HIPAA
- GDPR
- LGPD
- WHO digital health principles
- ISO 13485 (medical systems)
- ISO 14971 (risk management)
- IEC 62304 (medical software lifecycle)

Certification occurs post-competition only.

---

## 5. Interface-First Architecture Rule

Interfaces are permanent.  
Implementations are replaceable.

Therefore:
- APIs must be fully specified
- Contracts must expose intent clearly
- Boundaries between on-chain and off-chain systems must be explicit

No hidden coupling is allowed.

---

## 6. On-Chain Rules

On-chain systems:
- Store hashes, references, states, and attestations
- Do NOT store bulk data
- Do NOT perform computation-heavy logic
- Must remain gas-bounded and deterministic

Smart contracts are immutable anchors, not execution engines.

---

## 7. Off-Chain Rules

Off-chain systems:
- Perform AI inference
- Perform analytics
- Perform orchestration
- Must be auditable and reproducible

Every off-chain result must be:
- Hash-linked
- Timestamped
- Traceable on-chain

---

## 8. Security Posture

Hackathon phase security includes:
- Open-source transparency
- Static analysis
- Testnet deployment
- Verified contracts
- Explicit threat model documentation

Professional audits occur post-hackathon.

Security theater is prohibited.

---

## 9. Testing Standard

Healthcare-grade expectations apply.

Minimum requirements:
- Critical paths tested
- Failure paths documented
- Deterministic contract behavior verified

Coverage is expected to expand post-hackathon but **test absence is unacceptable**.

---

## 10. Failure Visibility Rule

Failures must:
- Be visible
- Be logged
- Be traceable

Silent failure is a critical defect.

---

## 11. Token & Incentive Discipline

Token logic must:
- Align with ABST
- Avoid speculative claims
- Avoid yield promises
- Remain parameterized

Tokenomics must be auditable and adjustable.

---

## 12. Open Source Conduct

NeuroGrid is open-source by design.

Therefore:
- CONTRIBUTING.md is mandatory
- CODE_OF_CONDUCT.md is mandatory
- Public issue tracking is mandatory

Solo development does not exempt governance discipline.

---

## 13. Non-Negotiable Rule

If an artifact:
- Cannot survive into production
- Creates false confidence
- Masks risk
- Requires rewrite post-hackathon

It must not be built.

---

## 14. Authority

This document supersedes:
- Personal preference
- Convenience
- Speed shortcuts
- Cosmetic demos

Violation of these rules invalidates system credibility.

---

**End of Build Rules**

