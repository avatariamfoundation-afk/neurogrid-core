NeuroGrid-Core

Deterministic Medical Compute & Governance Infrastructure

Executive Summary

NeuroGrid-Core is the deterministic on-chain coordination layer of the NeuroGrid ecosystem.

It provides a trust-minimized, auditable infrastructure for coordinating medical-grade compute, validator accountability, artifact lineage, and governance — without performing diagnosis, treatment, or autonomous clinical decision-making.

NeuroGrid-Core is designed to support compliant medical AI workflows, research validation, and decentralized scientific coordination while remaining strictly infrastructure-only.

This repository contains the Core Protocol Layer.

System Positioning (Critical)

NeuroGrid is intentionally split into three distinct layers:

DeSci (Silent Governance & Research Layer)
        ↓
NeuroGrid-Core (On-Chain Deterministic Infrastructure)
        ↓
MedIntel (Off-Chain Medical Intelligence & Analytics)


Each layer is independently valid, loosely coupled, and explicitly constrained.

What NeuroGrid-Core IS

A deterministic coordination protocol

An accountability and slashing framework

A verifiable execution and artifact registry

A governance enforcement layer

A compliance-aware infrastructure substrate

What NeuroGrid-Core IS NOT

❌ A diagnostic system

❌ A medical device

❌ A clinical decision engine

❌ An autonomous AI practitioner

❌ A patient data processor

NeuroGrid-Core enforces rules — it does not interpret medicine.

Core Design Principles
1. Determinism

Every action is:

Reproducible

Traceable

State-bound

Explicitly logged

No hidden execution paths.
No implicit trust.

2. Accountability

Validators, compute nodes, and governance actors are:

Role-scoped

Fault-coded

Slashable

Auditable

No silent success.
No silent failure.

3. Safety-First Architecture

Infrastructure-only scope

No autonomous inference

No clinical claims

Explicit failure states

4. Hackathon & Audit Readiness

Clear separation of concerns

Placeholder token abstraction

Frozen deployment states

Judge-safe documentation

Architecture Overview
Layer 1 — DeSci (External, Silent Root)

Not contained in this repository

The DeSci layer defines:

Research lifecycle specifications

Scientific governance frameworks

Ethics and compliance constraints

Funding and attribution models

Important:

DeSci does not deploy contracts

DeSci does not execute logic

DeSci provides context, not control

NeuroGrid-Core may reference DeSci outputs by hash or policy, but never depends on them for correctness.

Layer 2 — NeuroGrid-Core (This Repository)

Deterministic On-Chain Infrastructure

Primary Contracts

NeuroGridKernel
Global protocol state coordination

ComputeRegistry
Registration and lifecycle management of compute nodes

ArtifactRegistry
Artifact issuance, lineage, and verification

ValidatorManager
Validator enrollment, scoring, slashing, and fault escalation

NeuroDAO
Governance and policy enforcement

ProposalExecutor
Deterministic proposal execution

Telemetry Interface
Fault-coded execution reporting

Core Responsibilities

Enforce governance decisions

Register and constrain actors

Record artifacts and lineage

Emit deterministic telemetry

Apply slashing and penalties

Explicit Non-Responsibilities

Medical interpretation

Scientific truth validation

AI model execution

Patient data handling

Layer 3 — MedIntel (External, Downstream)

Not contained in this repository

MedIntel consists of:

AI models

Medical analytics

RPM and inference pipelines

Constraints:

Consumes only approved artifacts

Emits signed telemetry

Cannot modify governance

Cannot bypass fault logic

MedIntel is downstream and subordinate to Core enforcement.

Deterministic Trust Model

Trust is enforced through:

Immutable fault codes

Explicit role separation

Slashing-bound behavior

Verifiable execution paths

No implicit authority

All trust boundaries are:

Documented

Enforced on-chain

Auditable

Telemetry & Fault Codes

Every execution emits:

Deterministic telemetry

Explicit fault codes

Verifiable outcomes

There is no silent success
There is no silent failure

See:

TELEMETRY.md

FAULT_CODE.md

DETERMINISTIC_SLASHING_POLICY_SPEC.md

Token Model (Hackathon-Safe)
During Hackathon

MedToken

Non-speculative

Non-listed

Governance and validator simulation only

Post-Hackathon (Planned)

ABSToken

Utility-based

Subject to audit and regulatory review

Intended for:

Validator incentives

Governance participation

Telemetry verification

Ecosystem sustainability

Token transition is explicitly deferred.

Security Posture

No privileged execution paths

Explicit admin role separation

No silent upgrades

DAO-bound governance

Defense-in-depth design

See:

SECURITY_MODEL.md

DEFAULT_ADMIN_ROLE.md

GRID_ADMIN_ROLE.md

STRUCTURAL_HARDENING.md

Testing & Validation

The protocol includes a defined test matrix covering:

Happy paths

Permission violations

State-guard enforcement

Fault escalation

Slashing logic

See:

TEST_MATRIX.md

Deployment & Audit Status

Local deployment: Complete

opBNB Testnet deployment: Complete

Audit freeze: Applied

Deterministic state snapshot: Recorded

See:

DEPLOYMENT_NOTES.md

Regulatory & Ethical Positioning

Infrastructure-only

No medical claims

No patient data

Designed to support compliance, not replace it

NeuroGrid-Core is not a medical device.

Judge-Facing Clarity

This repository demonstrates:

Strong system design discipline

Deterministic trust enforcement

Clear separation between infrastructure and intelligence

Responsible post-hackathon planning

Awarded funds are intended for:

Independent security audits

Medical AI compliance review

Infrastructure hardening

Validator network maturation

Future compliant expansion

Repository Status

Core protocol: Finalized

Architecture: Frozen

Documentation: Hardened

Deployment: Verified

Demo & UI: Next Phase

Final Statement

NeuroGrid-Core is intentionally conservative.

It is designed to earn trust before demanding adoption.

Status:
NeuroGrid-Core — Audit-Frozen, Hackathon-Ready
