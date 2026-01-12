# API_READ_SURFACE.md
## NeuroGrid Core — Read-Only Execution & Observation Surface

---

## 1. PURPOSE

This document defines the **API Read Surface** for **NeuroGrid Core**.

The Read Surface represents **what external observers (judges, auditors, reviewers)** can safely inspect, execute, and verify **without modifying system state**.

This is a **deliberately constrained interface**, aligned with:
- Safety-first medical systems
- Deterministic execution
- Auditability over mutability

---

## 2. DESIGN PRINCIPLES

NeuroGrid Core exposes **no write-enabled external APIs**.

All observable behavior is:
- Deterministic
- Local
- Reproducible
- Non-networked

This prevents:
- Accidental state mutation
- Data leakage
- Unauthorized execution paths

---

## 3. READ SURFACE CATEGORIES

### 3.1 Execution Surface (CLI)

Judges interact with NeuroGrid Core **only via command-line execution**.

Primary entry point:

```bash
python demo/synthetic-datarun_demo.py
This command triggers:

Synthetic data generation

Kernel evaluation

Artifact creation

Telemetry emission

No parameters are required.

### 3.2 Observable Outputs
All system outputs are emitted to stdout (Command Prompt).

Output Classes
Synthetic Input Payload

Kernel Evaluation Result

Artifact Object

Telemetry Event Log

These outputs form the complete read surface.

---

## 4. DATA STRUCTURES (READ-ONLY)
### 4.1 Synthetic Patient Input
json
Copy code
{
  "patient_id": "SYNTH-001",
  "age": 45,
  "heart_rate": 72,
  "blood_oxygen": 98,
  "timestamp": "ISO-8601 UTC"
}
No external data ingestion

No real patient identifiers

Fully synthetic by design

### 4.2 Kernel Output
Safe Path

json
Copy code
{
  "status": "OK",
  "risk_score": 0.8
}
Fault Path

json
Copy code
{
  "status": "FAULT",
  "fault_code": "NG-FLT-001",
  "reason": "Hypoxia threshold breach"
}

### 4.3 Artifact Object
json
Copy code
{
  "artifact_type": "SYNTHETIC_DIAGNOSTIC_RESULT",
  "input": { ... },
  "result": { ... },
  "generated_at": "ISO-8601 UTC",
  "artifact_hash": "SHA-256"
}
Artifacts are immutable once emitted.

### 4.4 Telemetry Event
json
Copy code
{
  "event": "ARTIFACT_EMITTED",
  "artifact_hash": "<hash>",
  "timestamp": "<utc>"
}
Telemetry is:

Informational only

Non-persistent

Non-networked

---

## 5. READ SURFACE BOUNDARIES
Explicitly Supported
Execution

Observation

Screenshot capture

Deterministic re-run

Explicitly Unsupported
Parameter injection

External API calls

Network access

Persistent storage

State mutation

Any behavior outside this surface is out of scope.

---

## 6. SAFETY & COMPLIANCE POSITION
The restricted read surface ensures:

No clinical decision-making

No patient data processing

No treatment inference

No regulatory overreach

This positions NeuroGrid Core as:

A computational infrastructure demonstration, not a medical device.

---

## 7. JUDGE ACCESSIBILITY
Judges can validate the system by:

Running a single command

Observing deterministic output

Reviewing artifact structure

Confirming fault behavior

No setup beyond Python is required.

---

## 8. FUTURE EXTENSION (NON-BINDING)
Post-hackathon, the Read Surface may expand to:

Signed artifact export

API gateways (read-only)

Audit streaming endpoints

These are not implemented in this submission.

---

## 9. SUMMARY
The NeuroGrid Core API Read Surface is:

Minimal by intent

Safe by design

Transparent by default

Judge-friendly

It demonstrates engineering discipline under constraint, not feature incompleteness.

---

### Document Status: Final
Applies To: NeuroGrid Core
Audience: Judges, Auditors, Reviewers
