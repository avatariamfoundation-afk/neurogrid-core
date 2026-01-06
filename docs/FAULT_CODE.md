# FAULT_CODE.md

Repository: neurogrid-core  
Canonical Location: /docs/FAULT_CODE.md

---

## 1. Purpose

This document defines the **Deterministic Fault Code System** for NeuroGrid.

The system provides:
- Objective fault attribution
- Deterministic slashing triggers
- Cross-chain compatible telemetry
- Governance-controlled enforcement
- Audit and judge verifiability

All faults within NeuroGrid **must map to exactly one fault code** defined in this document.

---

## 2. Design Principles

1. Deterministic  
   Identical state and input must always produce the same fault code.

2. Non-Ambiguous  
   Each fault code represents exactly one class of failure.

3. Governance-Controlled  
   Severity and penalties are configurable via DAO governance.

4. Chain-Agnostic  
   Fault codes are identical across BNB Chain and Ethereum.

5. Telemetry-First  
   All faults must emit structured events.

---

## 3. Fault Code Format

All fault codes follow this canonical format:

NG-<DOMAIN>-<SEVERITY>-<ID>

Example:
NG-COMPUTE-MAJ-003

---

## 4. Severity Levels

| Code | Name | Description |
|-----|------|-------------|
| INFO | Informational | No penalty, logged only |
| WARN | Warning | No slashing, trust signal |
| MIN | Minor Fault | Reputation decay |
| MAJ | Major Fault | Slashing applied |
| CRIT | Critical Fault | Forced eviction |

Severity determines **maximum allowable enforcement**, not automatic punishment.

---

## 5. Fault Domains

| Domain | Description |
|------|-------------|
| KERNEL | Core protocol execution |
| COMPUTE | Compute node behavior |
| VALIDATOR | Validator duties |
| ARTIFACT | Model and artifact integrity |
| DAO | Governance execution |
| TOKEN | Token usage and supply |
| TELEMETRY | Event emission |
| SECURITY | Exploits and attacks |

---

## 6. Canonical Fault Registry

### 6.1 Kernel Faults

| Fault Code | Description |
|----------|-------------|
| NG-KERNEL-MIN-001 | Unauthorized kernel call |
| NG-KERNEL-MAJ-002 | Invalid state transition |
| NG-KERNEL-CRIT-003 | Kernel invariant violation |

---

### 6.2 Compute Node Faults

| Fault Code | Description |
|----------|-------------|
| NG-COMPUTE-WARN-001 | Late computation submission |
| NG-COMPUTE-MIN-002 | Incomplete computation |
| NG-COMPUTE-MAJ-003 | Invalid computation result |
| NG-COMPUTE-CRIT-004 | Proven malicious output |

---

### 6.3 Validator Faults

| Fault Code | Description |
|----------|-------------|
| NG-VALIDATOR-MIN-001 | Missed validation window |
| NG-VALIDATOR-MAJ-002 | False validation attestation |
| NG-VALIDATOR-CRIT-003 | Validator collusion |

---

### 6.4 Artifact Faults

| Fault Code | Description |
|----------|-------------|
| NG-ARTIFACT-MIN-001 | Artifact metadata mismatch |
| NG-ARTIFACT-MAJ-002 | Artifact hash inconsistency |
| NG-ARTIFACT-CRIT-003 | Tampered or poisoned artifact |

---

### 6.5 DAO / Governance Faults

| Fault Code | Description |
|----------|-------------|
| NG-DAO-WARN-001 | Proposal execution delay |
| NG-DAO-MAJ-002 | Unauthorized proposal execution |
| NG-DAO-CRIT-003 | Governance capture attempt |

---

### 6.6 Token Faults

| Fault Code | Description |
|----------|-------------|
| NG-TOKEN-MIN-001 | Improper token usage |
| NG-TOKEN-MAJ-002 | Slashing bypass attempt |
| NG-TOKEN-CRIT-003 | Supply or mint violation |

---

### 6.7 Telemetry Faults

| Fault Code | Description |
|----------|-------------|
| NG-TELEMETRY-WARN-001 | Delayed event emission |
| NG-TELEMETRY-MAJ-002 | Missing mandatory event |
| NG-TELEMETRY-CRIT-003 | Telemetry forgery |

---

### 6.8 Security Faults

| Fault Code | Description |
|----------|-------------|
| NG-SECURITY-MAJ-001 | Reentrancy attempt |
| NG-SECURITY-CRIT-002 | Privilege escalation |
| NG-SECURITY-CRIT-003 | Exploit confirmation |

---

## 7. On-Chain Fault Emission Standard

All faults MUST emit the following event:

event FaultDetected(
    address indexed actor,
    string faultCode,
    uint256 timestamp,
    bytes32 contextHash
);

Rules:
- faultCode must match this document exactly
- contextHash references off-chain evidence
- timestamp MUST be block.timestamp

---

## 8. Slashing & Enforcement Model

Fault codes do NOT directly enforce penalties.

They are routed through:
- ValidatorManager
- ProposalExecutor
- DAO governance configuration

This ensures:
- Deterministic outcomes
- Upgradeable enforcement
- Governance sovereignty

---

## 9. Cross-Chain Compatibility

Fault codes are:
- String-identical across chains
- Indexed consistently on BNB Chain and Ethereum
- Compatible with future L2 rollups

This enables unified dashboards and dispute resolution.

---

## 10. Governance Rules

The DAO MAY:
- Add new fault codes
- Adjust severity classification
- Modify enforcement thresholds

The DAO MAY NOT:
- Remove existing fault codes
- Reuse deprecated IDs

---

## 11. Audit & Judge Readiness

This system provides:
- Clear blame attribution
- Transparent slashing logic
- Deterministic enforcement

Designed for:
- Hackathon judging
- External audits
- Regulatory review

---

## 12. Status

State: Active  
Version: v1.0  
Scope: Core Protocol  
Change Control: DAO Governance

---

