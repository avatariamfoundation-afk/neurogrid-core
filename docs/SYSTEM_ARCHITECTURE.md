# NeuroGrid — System Architecture

## 1. Purpose of This Document
This document explains how NeuroGrid works at a system level.
It is written for:
- Hackathon judges
- Reviewers
- Non-engineering stakeholders
- Security and compliance evaluators

No source code knowledge is required to understand this document.

---

## 2. High-Level System Overview

NeuroGrid is a **decentralized medical intelligence framework** composed of three coordinated systems:

1. **CORE** — Trust, validation, governance, and blockchain logic  
2. **MEDINTEL** — Medical AI interface and clinician-facing intelligence layer  
3. **DESCI** — Decentralized science registry for traceability and auditability  

These systems are **loosely coupled**, meaning failure in one does not collapse the others.

---

## 3. Architecture Diagram (Conceptual)

[ User / Clinician / Researcher ]
|
v
┌─────────────────┐
│ MEDINTEL UI │
│ (AI Interface) │
└─────────────────┘
|
v
┌─────────────────┐
│ MEDINTEL API │
│ (Off-Chain AI) │
└─────────────────┘
|
| (validated outputs only)
v
┌────────────────────────────────────────┐
│ CORE │
│ - Validation Logic │
│ - Reputation │
│ - Incentives (ABST) │
│ - Governance │
│ - Smart Contracts (BNB Testnet) │
└────────────────────────────────────────┘
|
v
┌────────────────────────────────────────┐
│ DESCI │
│ - Research Registry │
│ - Validation Records │
│ - Immutable Proofs (Hashes) │
│ - Audit Trail │
└────────────────────────────────────────┘


---

## 4. Repository Responsibilities

### 4.1 CORE (Trust & Coordination Layer)

**What CORE does**
- Validates actions and outcomes
- Manages reputation and incentives
- Anchors trust to blockchain
- Enforces governance rules

**What CORE does NOT do**
- Store medical data
- Run AI models
- Perform inference

**Key Properties**
- Deployed on **BNB Testnet**
- Minimal on-chain storage (hashes only)
- Gas-optimized, upgrade-aware architecture
- ABST token alignment

---

### 4.2 MEDINTEL (Medical Intelligence Layer)

**What MEDINTEL does**
- Hosts AI inference (off-chain)
- Provides clinician-friendly interfaces
- Translates AI outputs into structured results

**What MEDINTEL does NOT do**
- Store patient-identifiable data on-chain
- Make autonomous medical decisions
- Bypass validation rules

**Key Properties**
- Off-chain by design
- AI outputs are *validated*, not blindly trusted
- Privacy-first architecture

---

### 4.3 DESCI (Decentralized Science Registry)

**What DESCI does**
- Records validation events
- Anchors research lineage
- Creates immutable audit trails

**What DESCI does NOT do**
- Run AI
- Handle payments
- Store raw datasets

**Key Properties**
- Registry-based architecture
- Hash-based proofs only
- Designed for long-term scientific auditability

---

## 5. Data Flow (Step-by-Step)

1. User submits request via MEDINTEL
2. AI inference runs **off-chain**
3. Result is structured and hashed
4. CORE validates:
   - permissions
   - integrity
   - reputation rules
5. Validation record is anchored
6. DESCI stores immutable registry entry
7. Incentives or reputation updates occur (if applicable)

No raw medical data ever touches the blockchain.

---

## 6. Security Architecture

### Key Principles
- **Minimal On-Chain Exposure**
- **Off-Chain Compute, On-Chain Trust**
- **Fail-Closed Validation**

### Implemented Controls
- Strict module boundaries
- Hash-only persistence
- Role-based permissions
- Explicit validation checkpoints
- Separation of concerns across repos

---

## 7. Compliance Positioning (Hackathon Scope)

NeuroGrid is designed to be compatible with:
- HIPAA (US)
- GDPR (EU)
- LGPD (Brazil)
- WHO-aligned data ethics principles

Important:
- No patient data is stored on-chain
- No medical claims are made
- System operates as a **decision-support framework**, not a diagnostic authority

---

## 8. Scalability Strategy

- AI inference scales horizontally off-chain
- Blockchain usage limited to trust anchors
- Batch anchoring supported
- Indexers and read-mirrors handle read load

This avoids blockchain bottlenecks while retaining decentralization.

---

## 9. Failure & Recovery Model

| Component | Failure Impact | Recovery |
|--------|---------------|----------|
MEDINTEL | AI unavailable | Retry / fallback |
CORE | Validation paused | Network retry |
DESCI | Registry delay | Eventual consistency |

No single failure compromises system integrity.

---

## 10. Hackathon Readiness Statement

For hackathon evaluation:
- System is live on **BNB Testnet**
- Code is open-source
- Architecture is modular and auditable
- Security posture is documented
- Upgrade path is intentional

This is a **real system foundation**, not a mock demo.

---

## 11. Forward Path (Post-Hackathon)

- Professional smart contract audit
- Expanded test coverage
- ZKP expansion
- Formal regulatory mapping
- Production-grade deployment automation

---

## 12. Final Note to Reviewers

NeuroGrid prioritizes:
- Safety over hype
- Trust over raw automation
- Architecture over shortcuts

This system is built to evolve into real-world medical infrastructure.

