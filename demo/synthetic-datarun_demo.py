"""
NeuroGrid Core — Synthetic Data Run Demo
---------------------------------------
Purpose:
- Demonstrate deterministic pipeline execution
- Simulate medical telemetry ingestion
- Emit artifacts + fault codes
- No external dependencies
"""

import hashlib
import json
import time
from datetime import datetime
from typing import Dict, Any


# -----------------------------
# Deterministic Utilities
# -----------------------------

def deterministic_hash(payload: Dict[str, Any]) -> str:
    encoded = json.dumps(payload, sort_keys=True).encode("utf-8")
    return hashlib.sha256(encoded).hexdigest()


def now_utc() -> str:
    return datetime.utcnow().isoformat() + "Z"


# -----------------------------
# Synthetic Medical Input
# -----------------------------

def generate_synthetic_patient() -> Dict[str, Any]:
    return {
        "patient_id": "SYNTH-001",
        "age": 45,
        "heart_rate": 72,
        "blood_oxygen": 98,
        "timestamp": now_utc()
    }


# -----------------------------
# NeuroGrid Pipeline (Mock)
# -----------------------------

def neurogrid_kernel(input_data: Dict[str, Any]) -> Dict[str, Any]:
    if input_data["blood_oxygen"] < 90:
        return {
            "status": "FAULT",
            "fault_code": "NG-FLT-001",
            "reason": "Hypoxia threshold breach"
        }

    return {
        "status": "OK",
        "risk_score": round((100 - input_data["blood_oxygen"]) * 0.4, 2)
    }


# -----------------------------
# Artifact Emission
# -----------------------------

def emit_artifact(input_data: Dict[str, Any], result: Dict[str, Any]) -> Dict[str, Any]:
    artifact = {
        "artifact_type": "SYNTHETIC_DIAGNOSTIC_RESULT",
        "input": input_data,
        "result": result,
        "generated_at": now_utc()
    }
    artifact["artifact_hash"] = deterministic_hash(artifact)
    return artifact


# -----------------------------
# Telemetry Output
# -----------------------------

def emit_telemetry(artifact: Dict[str, Any]) -> None:
    print("\n--- NEUROGRID TELEMETRY ---")
    print(json.dumps({
        "event": "ARTIFACT_EMITTED",
        "artifact_hash": artifact["artifact_hash"],
        "timestamp": artifact["generated_at"]
    }, indent=2))


# -----------------------------
# Demo Execution
# -----------------------------

def main():
    print("\n=== NEUROGRID CORE DEMO START ===\n")

    patient = generate_synthetic_patient()
    print("Synthetic Input:")
    print(json.dumps(patient, indent=2))

    result = neurogrid_kernel(patient)
    print("\nKernel Output:")
    print(json.dumps(result, indent=2))

    artifact = emit_artifact(patient, result)
    print("\nArtifact Created:")
    print(json.dumps(artifact, indent=2))

    emit_telemetry(artifact)

    print("\n=== DEMO COMPLETE ===\n")


if __name__ == "__main__":
    main()

