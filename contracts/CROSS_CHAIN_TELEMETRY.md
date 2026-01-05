# CROSS_CHAIN_TELEMETRY_COMPATIBILITY.md  
**NeuroGrid Core Protocol**

**Status:** Active  
**Scope:** BNB Chain ↔ Ethereum (EVM-Compatible)  
**Last Updated:** 2026-01-02  

---

## 1. Purpose

This document defines how **NeuroGrid telemetry, fault signals, and trust events** remain **deterministic, verifiable, and interoperable across chains**, with specific focus on:

- BNB Chain (Hackathon / Primary Deployment)
- Ethereum Mainnet / L2s (Post-Hackathon Expansion)

The goal is **telemetry portability without semantic drift**.

---

## 2. Design Principle

Cross-chain telemetry follows a strict rule:

> **Events are truth. Chains are transport layers.**

Telemetry **must not require reinterpretation** when mirrored or consumed on another chain.

---

## 3. Telemetry Invariants (Non-Negotiable)

The following invariants apply across all chains:

1. **Event Names Are Immutable**
2. **Field Ordering Is Frozen**
3. **Severity Semantics Are Identical**
4. **Fault Codes Never Change Meaning**
5. **No Chain-Specific Logic in Telemetry**

Breaking any invariant is considered a **protocol-level fault**.

---

## 4. Canonical Telemetry Schema

All chains emit **identical telemetry events**.

### 4.1 Canonical Fault Event

FaultEmitted(
bytes32 indexed faultCode,
address indexed actor,
address indexed target,
uint8 severity,
uint256 timestamp,
bytes32 contextHash
)


This schema is:

- ABI-stable
- Indexer-safe
- Chain-agnostic
- Replay-compatible

---

### 4.2 Canonical Execution Event

ExecutionRecorded(
bytes32 indexed executionId,
address indexed executor,
uint8 executionType,
uint256 timestamp,
bytes32 metadataHash
)


---

## 5. Chain Identity Abstraction

Telemetry does **not** encode chain identity inside events.

Instead, **chain identity is resolved externally** via:

- `chainId` (EVM-native)
- Emitting contract address
- Deployment metadata

This prevents event schema mutation.

---

## 6. Telemetry Bridging Model

### 6.1 Mirror, Do Not Translate

Telemetry crossing chains must:

- Be **mirrored verbatim**
- Preserve original event payload
- Preserve original ordering

❌ No transformation  
❌ No reclassification  
❌ No recomputation  

---

### 6.2 Supported Bridge Types

The following are compatible:

- Message-based bridges (LayerZero, Wormhole)
- Event proof relays
- Off-chain indexer attestations

The protocol **does not mandate a bridge**, only constraints.

---

## 7. Telemetry Receipt Verification

On destination chains, telemetry may be:

- Stored as a hash
- Re-emitted as a mirror event
- Indexed for analytics

### Example Receipt Event

TelemetryMirrored(
uint256 sourceChainId,
address sourceEmitter,
bytes32 originalEventHash,
uint256 mirroredAt
)


Receipts **do not assert truth**, only **presence**.

---

## 8. Governance & Cross-Chain Trust

Governance decisions **must reference telemetry by hash**, not chain.

Example:

- A fault emitted on BNB Chain
- Mirrored to Ethereum
- Referenced identically in governance proposals

This prevents chain-based manipulation.

---

## 9. Slashing & Enforcement Across Chains

### Hackathon Phase
- No cross-chain enforcement
- Telemetry is informational only

### Post-Hackathon
- Governance MAY:
  - Recognize mirrored telemetry
  - Enforce penalties on a primary chain
  - Require quorum confirmation

Automatic enforcement is **explicitly disallowed**.

---

## 10. Indexing & Analytics Guarantees

Telemetry is compatible with:

- The Graph
- Custom indexers
- SIEM-style pipelines

Indexers can safely aggregate telemetry across chains using:

- `(chainId, txHash, logIndex)`
- Event signature + payload hash

---

## 11. Failure Modes & Protections

| Risk | Mitigation |
|----|-----------|
| Event spoofing | Source emitter verification |
| Reordering | Timestamp + tx ordering |
| Replay | Event hash uniqueness |
| Bridge censorship | Multi-indexer validation |

---

## 12. Non-Goals

Cross-chain telemetry does **not**:

- Synchronize state
- Enforce cross-chain slashing
- Depend on a single bridge
- Encode trust assumptions in relayers

---

## 13. Compatibility Summary

| Component | Compatible |
|---------|------------|
| NeuroGridKernel | ✅ |
| ComputeRegistry | ✅ |
| ArtifactRegistry | ✅ |
| ValidatorManager | ✅ |
| NeuroDAO | ✅ |
| ProposalExecutor | ✅ |
| Telemetry Events | ✅ |
| Deterministic Fault Codes | ✅ |

---

## 14. Final Assertion

NeuroGrid telemetry is **portable truth**.

Chains may differ.  
Events do not.

This guarantees that **scientific accountability, validator behavior, and governance legitimacy** survive any future chain expansion without refactor.

---

**End of CROSS_CHAIN_TELEMETRY_COMPATIBILITY.md**
