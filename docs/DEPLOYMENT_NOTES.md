# DEPLOYMENT_NOTES.md

## Project
**Aethera BioSync / ABST Protocol**  
Deterministic, slashing-enforced, telemetry-aware decentralized compute and governance stack.

---

## 1. PURPOSE

This document defines **exact deployment procedures, ordering, dependencies, invariants, and post-deployment verification steps** for the ABST smart contract system.

It is written to be:
- Auditor-readable
- Operator-executable
- Deterministic across environments
- Chain-agnostic (EVM-compatible)

This document is **authoritative** for mainnet deployment.

---

## 2. DEPLOYMENT ENVIRONMENTS

| Environment | Chain Examples | Purpose |
|------------|---------------|--------|
| Local | Hardhat / Foundry | Deterministic testing |
| Testnet | Sepolia, Holesky | Slashing + telemetry validation |
| Mainnet | Ethereum, L2s | Production execution |
| Cross-chain | Polygon, Arbitrum | Telemetry mirroring |

---

## 3. CONTRACT DEPLOYMENT ORDER (MANDATORY)

Deployment **must** follow this exact sequence.

1. **ABSToken.sol**
2. **ProposalExecutor.sol**
3. **IComputeNode.sol (Registry / Interface-bound implementation)**
4. **SlashingController.sol**
5. **TelemetryRouter.sol**
6. **CrossChainTelemetryAdapter.sol (if enabled)**

Any deviation **invalidates deterministic assumptions**.

---

## 4. REQUIRED PRE-DEPLOY CONFIGURATION

### 4.1 Immutable Parameters

| Parameter | Description |
|---------|------------|
| `GENESIS_SUPPLY` | Fixed ABST mint |
| `SLASH_QUANTUM` | Minimum slash unit |
| `FAULT_CODE_DOMAIN` | Deterministic namespace |
| `EPOCH_LENGTH` | Governance + telemetry sync |
| `TELEMETRY_HASH_VERSION` | Prevent replay |

These values **cannot be changed post-deploy**.

---

## 5. ACCESS CONTROL ASSIGNMENTS

Immediately after deployment:

### ABSToken
- `MINTER_ROLE` → ProposalExecutor
- `BURNER_ROLE` → SlashingController
- `ADMIN_ROLE` → Multisig / DAO timelock

### ProposalExecutor
- Execution authority bound to DAO governance
- No EOAs permitted

### SlashingController
- Callable only by:
  - ProposalExecutor
  - TelemetryRouter (validated reports)

---

## 6. DETERMINISTIC SLASHING INVARIANTS

The following **must hold at all times**:

- Every slash event:
  - References a **Fault Code**
  - Includes **Epoch ID**
  - Emits a **SlashTelemetryEvent**
- Slashing is:
  - Non-reversible
  - Non-overrideable
  - Non-arbitrary

If any invariant fails → **deployment is invalid**.

---

## 7. TELEMETRY SYSTEM INITIALIZATION

### 7.1 TelemetryRouter Setup

- Register:
  - Fault Code Registry
  - SlashingController address
- Enable:
  - Epoch-bound hashing
  - Cross-chain hooks (if applicable)

### 7.2 Deterministic Hash Check

Telemetry payload hash must equal:

keccak256(
FAULT_CODE ||
NODE_ID ||
EPOCH ||
METRIC_VECTOR ||
VERSION
)


Mismatch = rejection.

---

## 8. CROSS-CHAIN TELEMETRY (OPTIONAL)

If enabled:

- Deploy `CrossChainTelemetryAdapter`
- Register allowed:
  - Source chains
  - Message relayers
- Enforce:
  - One-way telemetry (no governance authority)
  - Replay protection via epoch + nonce

Cross-chain telemetry **can trigger slashing**, but **cannot mint or vote**.

---

## 9. POST-DEPLOY VERIFICATION CHECKLIST

### Mandatory Checks

- [ ] Total ABST supply == GENESIS_SUPPLY
- [ ] ProposalExecutor holds MINTER_ROLE
- [ ] SlashingController holds BURNER_ROLE
- [ ] No EOA has privileged roles
- [ ] Fault codes resolve deterministically
- [ ] Telemetry hashes validate
- [ ] Slash events emit correctly

### Recommended Checks

- Simulate:
  - Honest node epoch
  - Faulted node slashing
- Verify:
  - Gas ceilings
  - Event indexing
  - Cross-chain relay latency

---

## 10. FAILURE MODES & RESPONSE

| Failure | Action |
|-------|--------|
| Wrong deploy order | Abort, redeploy |
| Role misassignment | Revoke + reassign immediately |
| Telemetry hash mismatch | Halt slashing |
| Cross-chain replay | Freeze adapter |

**No hotfixes allowed on mainnet.**

---

## 11. UPGRADE POLICY

- Core contracts: **Immutable**
- Allowed upgrades:
  - Telemetry adapters
  - Analytics consumers
- Governance-controlled via timelock only

---

## 12. FINAL ASSERTION

If this document is followed **exactly**, the system guarantees:

- Deterministic enforcement
- Non-arbitrary punishment
- Audit-grade traceability
- Cross-chain observability without authority leakage

Any deviation is considered **protocol malpractice**.

---

**Status:** DEPLOYMENT-AUTHORIZED  
**Scope:** MAINNET  
**Revision:** v1.0 (Locked)
