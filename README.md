## Quick Start for Judges

➡️ **Start here:**  
[SYSTEM_OVERVIEW.md](./SYSTEM_OVERVIEW.md)

This one-page document explains the full NeuroGrid system, live deployment, and design intent in under 2 minutes.

---

## NeuroGrid-Core (Summary)
NeuroGrid is a deterministic coordination protocol for medical-grade computation, governance, and verifiable artifacts.
It enables trust-minimized medical AI infrastructure without performing diagnosis, treatment, or autonomous clinical decision-making.
Built on opBNB

---

## The Problem
Medical AI systems fail trust tests because they are:
Opaque
Non-reproducible
Weakly governed
Difficult to audit
Risky to deploy legally

## The Solution
NeuroGrid separates intelligence, governance, and enforcement into clean, auditable layers.
No black boxes.
No silent execution.
No unsafe claims.

---

## System Architecture (Simplified)
┌──────────────────────────────────────────────┐
│                  USERS / JUDGES              │
│        (Observers, Evaluators, DAO View)     │
└──────────────────────────────────────────────┘
                    │
                    ▼
┌──────────────────────────────────────────────┐
│            NEUROGRID – CORE (ON-CHAIN)        │
│              LIVE ON opBNB TESTNET            │
│                                              │
│  • Compute Registry                           │
│  • Artifact Registry                          │
│  • Validator Manager                          │
│  • Deterministic Telemetry                    │
│  • Fault Codes & Slashing Logic               │
│                                              │
│  → Smart contracts enforce coordination,      │
│    accountability, and auditability           │
└──────────────────────────────────────────────┘
                    │
                    │ (Deterministic Signals)
                    ▼
┌──────────────────────────────────────────────┐
│            MEDINTEL (OFF-CHAIN – STUB)        │
│        AI / Analytics / Inference Layer       │
│                                              │
│  • No execution during hackathon              │
│  • No patient data                            │
│  • Interfaces only                            │
│                                              │
│  → Future AI pipelines connect here           │
│    under governance and audit control         │
└──────────────────────────────────────────────┘
                    │
                    │ (Governance & Provenance)
                    ▼
┌──────────────────────────────────────────────┐
│          DESCI LAYER (SILENT / ROOT)          │
│   Ethics • Provenance • Research Governance   │
│                                              │
│  • No token logic                             │
│  • No execution paths                         │
│  • DAO & policy coordination only             │
│                                              │
│  → Ensures long-term compliance, trust,       │
│    and research integrity                     │
└──────────────────────────────────────────────┘

---

## What Is Live (Hackathon-Valid)
NeuroGrid-Core smart contracts
Deployed on opBNB Testnet
≥2 successful transactions
Open-source
No prior hackathon participation

---

## What Is Intentionally Stubbed
AI models (MedIntel)
Clinical logic
Patient data handling
This is by design for safety, legality, and audit clarity.

---

## Why This Matters to BNB Chain
Strong fit for infrastructure, governance, and scalability
Demonstrates responsible AI architecture
Ready for future DeSci + AI ecosystems
Clear upgrade path post-hackathon

---

## Killer Use Case (Conceptual)
Verifiable Medical Analytics Pipeline
External analytics run off-chain
Results are signed
Artifacts are registered on-chain
Validators attest correctness
Faults trigger slashing
No diagnosis.
Full accountability.

---

## Status
Core logic: Frozen
Architecture: Complete
Deployment: Verified
Expansion: Post-hackathon

---
## NeuroGrid-Core (Full README)

## Executive Summary
NeuroGrid is a deterministic coordination and accountability layer for medical-grade computation, research workflows, and AI-assisted analysis.

It enables:
Verifiable compute execution
Auditable artifact lineage
Fault-coded telemetry
Validator accountability
DAO-governed policy enforcement
NeuroGrid does not perform diagnosis or treatment.
It is infrastructure, not a medical device.

This repository (neurogrid-core) contains the on-chain core protocol deployed on opBNB Testnet.

---
## CI / Automation Status (Hackathon Scope)

Continuous Integration (CI) workflows are intentionally disabled during the hackathon submission window.

### Reasoning:
- Core protocol logic is finalized, frozen, and deployed on opBNB testnet
- No further contract mutations are permitted pre-judging
- CI scaffolding (extended tests, fuzzing, gas profiling) is scheduled post-hackathon

### This avoids false-negative CI signals caused by:
- intentionally stubbed MedIntel modules
- placeholder governance and validator flows
- environment-specific testnet configuration

### CI will be re-enabled post-hackathon with:
- full test matrix
- coverage reports
- security scanning
- upgrade safety checks

---

## What NeuroGrid Is (and Is Not)
### NeuroGrid IS
A compute coordination protocol
A deterministic trust framework
A governance and accountability layer
A compliance-aware substrate for medical AI

### NeuroGrid IS NOT
A diagnostic engine
A clinical decision-maker
An autonomous AI doctor
A patient data processor
NeuroGrid supports compliant systems — it does not replace clinicians, regulators, or medical judgment.

---

## System Architecture (Full Stack)
NeuroGrid is a three-layer system, intentionally modular.

┌────────────────────────────────────────────┐
│              DeSci Layer (Silent)           │
│  Research registries • Ethics • Provenance │
│  Funding logic • DAO-aligned coordination  │
│  (Off-chain, open-source, non-executing)  │
└────────────────────────────────────────────┘
                    ▲
                    │ references / governance signals
                    │
┌────────────────────────────────────────────┐
│            MedIntel Layer (Stubbed)         │
│  AI pipelines • RPM logic • Analytics      │
│  NO diagnosis • NO patient data            │
│  Future clinical integrations              │
└────────────────────────────────────────────┘
                    ▲
                    │ deterministic execution
                    │
┌────────────────────────────────────────────┐
│          NeuroGrid-Core (THIS REPO)         │
│  On-chain coordination & enforcement       │
│  Validators • Compute • Artifacts • DAO    │
│  Deployed on opBNB Testnet                  │
└────────────────────────────────────────────┘

---

## Repository Scope (This Repo)
Neurogrid-core contains ONLY the on-chain protocol.
### Included:
Deterministic compute coordination
Validator registration and slashing
Artifact issuance and lineage tracking
Fault-coded telemetry enforcement
Governance hooks (DAO-controlled)

### Excluded by design:
AI models
Medical logic
Patient data
Off-chain execution engines

---

## Core On-Chain Components
### Contract	                   ### Purpose
NeuroGridKernel	                 Global system coordinator
ComputeRegistry	                 Compute node lifecycle
ArtifactRegistry	               Artifact issuance & lineage
ValidatorManager	               Validator scoring & slashing
NeuroDAO	                       Governance & policy control
ProposalExecutor	               Deterministic execution
Telemetry Interface	             Fault-coded reporting

---

## Deterministic Trust Model

NeuroGrid enforces trust via explicit rules, not assumptions.
Deterministic execution paths
Immutable fault codes
Slashable validator behavior
Explicit failure states

❌ No silent success
❌ No silent failure
❌ No opaque inference

---

## Telemetry & Fault Codes

Every execution emits:
Deterministic telemetry
Explicit fault codes
Verifiable outcomes

Key documentation:
## TELEMETRY.md
## FAULT_CODE.md
## DETERMINISTIC_SLASHING_POLICY_SPEC.md

---

Token Model (Hackathon-Safe)
During Hackathon
### MedToken (placeholder)
Non-speculative
Non-transferable utility
Used for:
Validator incentives
Governance simulation
Fault accountability

Post-Hackathon (Planned)
### ABSToken
Subject to:
Audit
Legal review
Regulatory assessment
No token launch, listing, or monetization occurs during the hackathon.

---

## Security Posture
No privileged backdoors
No hidden upgrade paths
Upgradeability gated by governance
Explicit role separation
Defense-in-depth design

See:
## SECURITY_MODEL.md
## STRUCTURAL_HARDENING.md
## DEFAULT_ADMIN_ROLE.md
## GRID_ADMIN_ROLE.md

---

## Deployment (opBNB Testnet)
Network: opBNB Testnet
Deterministic deployment order
Publicly verifiable contracts
≥2 successful on-chain transactions

See:

## DEPLOYMENT_BNB_TESTNET.md

---

## Hackathon Compliance (BNB Chain)
✔ Deployed on opBNB Testnet
✔ Open source
✔ No prior hackathon participation
✔ Public GitHub repositories
✔ Live contract with transactions
✔ Clear demo and documentation
✔ Infrastructure-only (no medical claims)

---

## Real-World Use Case (Example)
Scenario: Medical AI Research Validation
Research compute is registered
Execution produces verifiable artifacts
Validators attest to correctness
Telemetry logs faults or success
DAO governs future policy updates

# This enables:

Trust-minimized medical research
Auditable AI workflows
Regulatory-aligned infrastructure

--- 

## Roadmap (Post-Hackathon)
Independent security audit
Validator network expansion
MedIntel controlled activation
DeSci ecosystem integrations
Compliant enterprise pilots

---

## Repository Status
Core protocol: Finalized
Documentation: Judge-optimized
Tests: Defined & passing
Deployment: Live on opBNB Testnet
Upgrade state: Frozen (v1.0.0)

---

## Final Note
NeuroGrid is intentionally conservative.
It is built to earn trust before demanding adoption.
Status: Core Protocol – Audit Frozen
Release: v1.0.0
Network: opBNB Testnet
