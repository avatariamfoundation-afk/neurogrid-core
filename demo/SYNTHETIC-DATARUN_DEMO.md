# SYNTHETIC-DATARUN_DEMO.md`

---

## 1. Purpose of This Demo

This document describes a **fully deterministic, non-clinical, synthetic data demonstration** of NeuroGrid.

It exists to:
- Prove system functionality without real medical data
- Demonstrate end-to-end flow for judges
- Validate determinism, provenance, and governance
- Avoid any ethical or regulatory boundary violations

This demo is **safe, auditable, and non-clinical by design**.

---

## 2. What This Demo Is (and Is Not)

### ✅ This Demo Is
- Synthetic (fabricated) data only
- Non-identifiable
- Non-diagnostic
- Deterministic
- Reproducible
- Infrastructure-focused

### ❌ This Demo Is NOT
- A medical diagnosis
- A clinical simulation
- A patient workflow
- A predictive health claim
- A treatment recommendation

---

## 3. High-Level Demo Overview

The demo demonstrates the following pipeline:

Synthetic Input
↓
MedIntel Inference (Deterministic)
↓
Artifact Emission
↓
NeuroGrid Core Registration
↓
Validator Attestation
↓
On-chain Telemetry & Events


Each step produces **verifiable artifacts** and **logged events**.

---

## 4. Synthetic Dataset Description

### Dataset Name
`SYNTH_BIOSIGNAL_V1`

### Data Characteristics
- Generated programmatically
- No human origin
- No biological meaning
- Fixed seed for reproducibility

### Example Fields
```json
{
  "signal_id": "SYNTH-001",
  "timestamp": 1735689600,
  "channel_count": 4,
  "sample_rate_hz": 250,
  "duration_seconds": 60,
  "values_checksum": "0xabc123..."
}

---

## 5. Deterministic Inference Step

- Inference Constraints
- Fixed model version
- Fixed parameters
- Fixed execution path
- Fixed output schema

## Example Output

{
  "artifact_type": "INFERENCE_RESULT",
  "model_id": "MEDINTEL-DEMO-V1",
  "deterministic_hash": "0xdeadbeef...",
  "confidence_bucket": "LOW",
  "notes": "Synthetic output – no biological meaning"
}

No probabilities, no adaptive behavior, no learning.

---

## 6. Artifact Emission

The inference output is wrapped into an Artifact Envelope:
- Artifact Fields
- Artifact ID (hash-based)
- Source module
- Deterministic checksum
- Timestamp
- Metadata schema version
- This artifact becomes the single unit of truth.

---

## 7. NeuroGrid Core Registration

Artifact is submitted to:

ArtifactRegistry

Linked to:
- Validator set
- Compute node ID
- Governance domain
- On-chain Actions
- Artifact registration event
- Immutable reference stored
- State transition recorded

---

## 8. Validator Attestation

Validators perform:

Structural validation

Schema verification

Deterministic hash confirmation

Outcome Options

## ACCEPTED

## REJECTED (with fault code)

No subjective scoring is allowed.

---

## 9. Telemetry & Events Emitted

The following events are emitted:

Event	Purpose
ArtifactRegistered	Proof of submission
ValidatorAttested	Proof of verification
ComputeLogged	Provenance of execution
FaultEmitted (optional)	Deterministic failure

All events are:
- Deterministic
- Queryable
- Non-silent

---

## 10. Fault Handling (If Triggered)

If validation fails:
- Execution halts
-Fault code emitted
- No retries without governance approval

## Example:

## FAULT_CODE: ARTIFACT_HASH_MISMATCH
SEVERITY: HARD_FAIL

---

## 11. What Judges Should Look For

Judges can verify:
- Deterministic behavior
- Clear audit trail
- Ethical boundaries respected
- No hidden intelligence
- Infrastructure maturity
- This is not a flashy demo by design.

---

## 12. Why Synthetic Data Is Used

Synthetic data ensures:
- Zero ethical risk
- Zero regulatory exposure
- Maximum transparency
- Judge-safe evaluation
- This is intentional and permanent for demos.

---

## 13. Reproducibility Guarantee

This demo can be:
- Re-run
- Re-verified
- Replayed
- Independently audited
- Same inputs → same outputs.

---

## 14. Extension Path (Post-Hackathon)

Future deployments may:
- Replace synthetic data with institutional pipelines
- Integrate audited datasets
- Operate behind clinical systems

Only with:

- Explicit governance approval
- External compliance validation

---

## 15. Final Statement

This demo proves:
NeuroGrid works without pretending to be medicine.
- That is the point.
- Document Status: Final
- Audience: Judges, Reviewers, Auditors
- Scope: Demo Only (Non-Clinical)
