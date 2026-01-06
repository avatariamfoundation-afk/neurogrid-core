# TEST_MATRIX.md  
NeuroGrid / MedIntel – Deterministic Test Coverage Matrix  
Version: v1.0  
Status: Hackathon-Compliant | Production-Aware  
Scope: Core Protocol, Governance, Token Flow, Telemetry, Slashing  

---

## 1. PURPOSE & INTENT

This document defines the **explicit test intent** for the NeuroGrid protocol stack.

It does **not** claim exhaustive test coverage.  
It demonstrates **engineering discipline, risk awareness, and deterministic system validation** appropriate for:

- Healthcare-adjacent computation
- Decentralized validator networks
- Governance-controlled execution
- Token-mediated incentive flows

The matrix is designed to be:
- Judge-readable
- Auditor-legible
- Developer-executable

---

## 2. TEST CATEGORIES

All tests are classified into three mandatory categories:

1. **Happy Path Tests**  
2. **Permission Failure Tests**  
3. **State Guard & Invalid Transition Tests**

Each test is deterministic and must produce a **binary outcome**:
- PASS → expected state transition
- FAIL → revert / reject / no-op with telemetry emission

---

## 3. HAPPY PATH TESTS

### 3.1 Compute Lifecycle

| ID | Scenario | Actor | Expected Result |
|----|--------|-------|----------------|
| HP-C-01 | Register compute node | Valid node | Node registered |
| HP-C-02 | Submit compute job | Registered node | Job accepted |
| HP-C-03 | Complete compute job | Assigned node | Completion recorded |
| HP-C-04 | Emit telemetry | Kernel | Telemetry event logged |
| HP-C-05 | Reward issuance | Protocol | Tokens issued |

---

### 3.2 Artifact Lifecycle

| ID | Scenario | Actor | Expected Result |
|----|--------|-------|----------------|
| HP-A-01 | Register artifact | Authorized contributor | Artifact stored |
| HP-A-02 | Verify artifact | Validator | Status updated |
| HP-A-03 | Artifact usage | Compute layer | Reference resolved |

---

### 3.3 Governance Flow

| ID | Scenario | Actor | Expected Result |
|----|--------|-------|----------------|
| HP-G-01 | Submit proposal | Governance role | Proposal accepted |
| HP-G-02 | Vote | Validator | Vote counted |
| HP-G-03 | Reach quorum | DAO | Proposal passes |
| HP-G-04 | Execute proposal | Executor | Action applied |

---

### 3.4 Token Flow (Hackathon Context)

| ID | Scenario | Actor | Expected Result |
|----|--------|-------|----------------|
| HP-T-01 | MedToken mint | Protocol | Mint succeeds |
| HP-T-02 | MedToken reward | Validator | Balance increases |
| HP-T-03 | Token cap enforcement | Protocol | Cap respected |

> Note: MedToken is a **hackathon-only placeholder**.  
> ABSToken logic is intentionally dormant in this phase.

---

## 4. PERMISSION FAILURE TESTS

### 4.1 Compute & Artifact Permissions

| ID | Scenario | Actor | Expected Result |
|----|--------|-------|----------------|
| PF-C-01 | Unregistered node submits job | External | Revert |
| PF-C-02 | Non-validator verifies artifact | User | Reject |
| PF-C-03 | Duplicate node registration | Node | Revert |

---

### 4.2 Governance Permissions

| ID | Scenario | Actor | Expected Result |
|----|--------|-------|----------------|
| PF-G-01 | Non-governance proposal | User | Reject |
| PF-G-02 | Vote without stake | Address | Vote ignored |
| PF-G-03 | Execute without quorum | Executor | Revert |

---

### 4.3 Token Permissions

| ID | Scenario | Actor | Expected Result |
|----|--------|-------|----------------|
| PF-T-01 | Unauthorized mint | External | Revert |
| PF-T-02 | Double reward claim | Validator | Revert |
| PF-T-03 | ABSToken interaction | Any | Blocked |

---

## 5. STATE GUARD & INVALID TRANSITION TESTS

### 5.1 Compute State Guards

| ID | Scenario | Invalid Condition | Expected Result |
|----|--------|------------------|----------------|
| SG-C-01 | Complete before assignment | No job | Revert |
| SG-C-02 | Reward before completion | Incomplete job | Revert |
| SG-C-03 | Re-complete job | Completed job | Reject |

---

### 5.2 Governance State Guards

| ID | Scenario | Invalid Condition | Expected Result |
|----|--------|------------------|----------------|
| SG-G-01 | Execute expired proposal | Past deadline | Revert |
| SG-G-02 | Re-execute proposal | Already executed | Reject |
| SG-G-03 | Vote after close | Voting ended | Ignore |

---

### 5.3 Token State Guards

| ID | Scenario | Invalid Condition | Expected Result |
|----|--------|------------------|----------------|
| SG-T-01 | Exceed supply cap | Max reached | Revert |
| SG-T-02 | Transfer locked token | Lock active | Revert |
| SG-T-03 | MedToken after deprecation | Deprecated | Blocked |

---

## 6. TELEMETRY ASSERTIONS

All failures and reverts must emit **deterministic telemetry**, including:

- Fault Code
- Actor
- Module
- Timestamp
- Severity

Telemetry must **not** affect execution outcome.

---

## 7. SLASHING INTERACTION (REFERENCE)

Slashing is **not executed** during hackathon deployment, but tests ensure:

- Fault detection is logged
- Slashing eligibility is flagged
- No automatic penalty is applied

This ensures **forward compatibility** with production ABSToken slashing.

---

## 8. NON-GOALS

This matrix explicitly does **not** include:
- Fuzz testing
- Formal verification proofs
- Gas benchmarking
- Cross-chain execution tests (telemetry only)

These are **post-hackathon enhancements**.

---

## 9. CONCLUSION

This Test Matrix ensures:
- Deterministic behavior
- Permission integrity
- State safety
- Governance correctness
- Token discipline

It establishes NeuroGrid as a **production-aware system**, even within a hackathon scope.

---

