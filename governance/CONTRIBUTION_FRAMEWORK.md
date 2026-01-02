# CONTRIBUTION_FRAMEWORK.md

## 1. Purpose

This document defines how external and internal contributors may participate in the NeuroGrid ecosystem across all repositories. It establishes standards for code quality, security, governance alignment, and hackathon readiness while remaining compatible with long-term production deployment.

Scope:

* Repositories: `core`, `medintel`, `desci`
* Open-source, hackathon-first, production-aligned

---

## 2. Contribution Principles

All contributions must adhere to the following principles:

1. **Security-First** – No contribution may weaken cryptographic, privacy, or system integrity guarantees.
2. **Deterministic & Auditable** – Changes must be reproducible and traceable.
3. **Modular & Minimal** – Contributions should be isolated, composable, and avoid unnecessary complexity.
4. **Open by Default** – Code, documentation, and design decisions must be transparent.
5. **Hackathon-Compatible** – Contributions must not introduce dependencies that block testnet deployment, demo execution, or judging.

---

## 3. Repository Contribution Boundaries

### 3.1 `core`

Allowed contributions:

* Smart contracts
* Token logic (ABST-aligned)
* On-chain governance primitives
* Security hardening
* Gas optimization

Restricted:

* Experimental AI logic
* Off-chain data processing

Requirements:

* Solidity best practices
* Explicit testnet compatibility (BNB Testnet)
* No mainnet assumptions

---

### 3.2 `medintel`

Allowed contributions:

* AI/ML pipelines
* Model evaluation
* Privacy-preserving compute logic
* Off-chain inference services

Restricted:

* Direct smart contract interaction without interface definition in `core`

Requirements:

* Reproducible runs
* Dataset abstraction (no raw medical data)
* Clear API surface definitions

---

### 3.3 `desci`

Allowed contributions:

* Research workflows
* Decentralized validation logic
* Reputation or contribution scoring mechanisms
* DAO tooling

Restricted:

* Production credentialing claims

Requirements:

* Explicit experimental labeling
* Clear separation from regulated medical outputs

---

## 4. Contributor Workflow

### Step 1: Fork & Branch

* Fork the relevant repository
* Create a feature branch using the format:

  * `feature/<short-description>`
  * `fix/<short-description>`

### Step 2: Implement Changes

* Follow repository-specific coding standards
* Keep commits atomic and descriptive

### Step 3: Self-Verification

Before submission, contributors must:

* Run all available tests
* Verify no secrets or credentials are committed
* Confirm compatibility with BNB testnet (if applicable)

### Step 4: Pull Request Submission

Each PR must include:

* Clear description of changes
* Rationale and intended impact
* Security considerations
* Affected components

---

## 5. Review & Acceptance Criteria

A contribution may be accepted only if:

* It passes automated checks (where available)
* It introduces no critical or high-risk vulnerabilities
* It aligns with NeuroGrid architecture and roadmap
* It does not break hackathon demo flows

Maintainers reserve the right to:

* Request revisions
* Reject contributions without obligation to merge

---

## 6. Security & Responsible Disclosure

* Vulnerabilities must **not** be disclosed publicly
* Security issues should be reported via private channels defined in `SECURITY_POSTURE.md`
* Contributors must not exploit discovered vulnerabilities

---

## 7. Licensing & IP

* All contributions are accepted under the repository’s open-source license
* Contributors affirm that they have the right to submit the code
* No proprietary, patented, or restricted code may be introduced

---

## 8. Hackathon-Specific Rules

During hackathon phases:

* Stability > feature expansion
* Testnet readiness is mandatory
* Demo reliability takes priority over optimization
* Experimental features must be clearly flagged

---

## 9. Governance Alignment

* Contributions impacting tokenomics, governance, or incentives must align with ABST design principles
* Any economic changes require explicit documentation and justification
* No unilateral changes to supply, sinks, or incentive flows

---

## 10. Enforcement

Failure to comply with this framework may result in:

* PR rejection
* Contributor suspension
* Removal of previously accepted code

This framework is mandatory for all contributors.

---

**Status:** Active
**Applies To:** All NeuroGrid repositories

