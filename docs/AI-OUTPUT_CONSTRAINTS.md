# AI OUTPUT CONSTRAINTS  
**NeuroGrid-Core**  
**Document ID:** AI-OUTPUT_CONSTRAINTS.md  
**Status:** Final — Judge-Ready  
**Scope:** Research Demonstration / Hackathon Submission  
**Last Updated:** 2026-01-10  

---

## 1. PURPOSE

This document defines strict constraints on **AI-generated outputs** within NeuroGrid-Core.  
Its purpose is to ensure that system outputs:

- Are non-clinical
- Are non-diagnostic
- Cannot be interpreted as medical advice
- Remain within research, simulation, and decision-support boundaries

This document governs **what the AI is allowed to say, predict, or emit**.

---

## 2. OUTPUT CLASSIFICATION MODEL

All AI outputs fall into one of the following **explicitly permitted classes**:

### 2.1 Permitted Output Classes

- Statistical summaries
- Confidence scores (non-clinical)
- Pattern indicators
- Anomaly flags (non-diagnostic)
- Risk signals (abstract, non-medical)
- System telemetry
- Model confidence / uncertainty indicators
- Simulation outcomes

---

## 3. EXPLICITLY PROHIBITED OUTPUTS

The AI **must never produce**:

- Medical diagnoses
- Treatment recommendations
- Prognoses
- Prescriptions
- Clinical decisions
- Probability of disease presence
- Statements implying patient health status
- Language implying medical authority

Examples of prohibited outputs:
- “The patient has condition X”
- “Immediate treatment is required”
- “This indicates disease Y”
- “Administer medication Z”

---

## 4. LANGUAGE CONSTRAINTS

### 4.1 Allowed Language Patterns

AI outputs are constrained to:

- Neutral
- Descriptive
- Abstract
- Probabilistic
- Uncertain
- System-focused

Example:
> “Pattern deviation detected relative to baseline simulation parameters.”

### 4.2 Disallowed Language Patterns

The AI must not use:

- Clinical terminology implying diagnosis
- Certainty-based medical claims
- Human-subject framing
- Actionable medical instructions

---

## 5. CONTEXTUAL BOUNDARIES

### 5.1 No Patient Framing

Outputs must not reference:
- Patients
- Individuals
- Humans
- Subjects
- Cases
- Demographics

All outputs refer to:
- Signals
- Inputs
- Data points
- Simulated entities
- Abstract nodes

---

## 6. OUTPUT STRUCTURE ENFORCEMENT

### 6.1 Structured Output Schema

AI responses are constrained to structured formats such as:

- JSON-like signal objects
- Tabular summaries
- Metric-based outputs
- Event logs

This prevents narrative drift into advisory language.

---

## 7. CONFIDENCE & UNCERTAINTY HANDLING

### 7.1 Mandatory Uncertainty Signaling

Every output includes one or more of:

- Confidence bounds
- Uncertainty indicators
- Signal strength ranges
- Reliability scores

The AI may **never** present absolute certainty.

---

## 8. HUMAN OVERSIGHT ASSUMPTION

The system assumes:

- Outputs are reviewed by a human
- Interpretations are external
- Decisions are not automated
- AI outputs are informational only

No closed-loop clinical action is supported.

---

## 9. DEMO-SPECIFIC CONSTRAINTS

During demos:

- Outputs are visibly labeled as “Simulation Output”
- Medical disclaimers are included
- Outputs are intentionally abstracted
- No real-world interpretation is encouraged

---

## 10. MISUSE PREVENTION

If prompts attempt to elicit prohibited outputs:

- The system must refuse
- The output must remain neutral
- A safety message may be returned
- Execution may halt if constraints are violated

---

## 11. REGULATORY POSITIONING (NON-CLAIM)

NeuroGrid-Core does **not** qualify as:

- A medical device
- Clinical decision support software
- Diagnostic AI
- Treatment planning system

No regulatory approval is claimed or implied.

---

## 12. FINAL ASSERTION

NeuroGrid-Core AI outputs are:

- Constrained
- Non-clinical
- Non-diagnostic
- Safe by design
- Aligned with ethical AI principles

These constraints are **structural**, not optional.

---

**End of Document**
