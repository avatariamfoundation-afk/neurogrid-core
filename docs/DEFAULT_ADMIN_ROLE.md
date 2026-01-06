DEFAULT_ADMIN_ROLE.md

DEFAULT_ADMIN_ROLE.md

1. Purpose

This document formally defines the DEFAULT_ADMIN_ROLE within the NeuroGrid Core protocol.

The DEFAULT_ADMIN_ROLE represents the root authority of the system. It exists to enable secure bootstrapping, controlled upgrades, and emergency intervention while enforcing strict separation from operational roles.

This role is intentionally powerful, explicitly constrained, and transparently documented.

2. Role Identifier

Solidity identifier:

bytes32 public constant DEFAULT_ADMIN_ROLE = 0x00;

Inherited from OpenZeppelin AccessControl

Universally recognized as the system’s root role

Cannot be disabled or removed

3. Core Responsibilities

The DEFAULT_ADMIN_ROLE is responsible for:

Assigning and revoking all protocol roles

Managing contract upgrade authorization (UUPS)

Bootstrapping governance and role hierarchies

Executing emergency safety actions

Initializing and recovering critical system parameters

This role does not participate in routine protocol operations.

4. Privileges

A holder of DEFAULT_ADMIN_ROLE may:

Grant and revoke the following roles:

GRID_ADMIN_ROLE

VALIDATOR_ROLE

COMPUTE_NODE_ROLE

GOVERNANCE_ROLE

Authorize logic upgrades for UUPS contracts

Pause or unpause protocol modules (if enabled)

Trigger emergency recovery actions

Transfer administrative control to governance systems

5. Explicit Restrictions

The DEFAULT_ADMIN_ROLE must never:

Submit compute results

Validate artifacts

Vote on proposals

Participate in incentive distribution

Perform day-to-day protocol functions

Operational authority and administrative authority are strictly separated.

6. Role Assignment Model
6.1 Initial Assignment

At deployment, DEFAULT_ADMIN_ROLE SHOULD be assigned to:

A multisig wallet, or

A DAO-controlled timelock contract

Assignment to a single EOA is strongly discouraged.

6.2 Post-Bootstrap Transition

Once the protocol stabilizes:

DEFAULT_ADMIN_ROLE SHOULD be transferred to:

A governance executor contract, or

A DAO-controlled timelock

This transition is considered mandatory for production systems.

7. Upgrade Authority (UUPS)

DEFAULT_ADMIN_ROLE exclusively controls:

_authorizeUpgrade(address newImplementation)

Upgrade assumptions:

All upgrades are announced

All upgrades emit deterministic events

No silent or retroactive upgrades are permitted

Abuse of upgrade authority is classified as a CRITICAL PROTOCOL FAULT.

8. Emergency Powers

In verified emergency scenarios, DEFAULT_ADMIN_ROLE may:

Freeze validator activity

Halt compute ingestion

Pause artifact registration

Temporarily suspend rewards

Emergency actions must:

Emit deterministic telemetry events

Be time-bounded

Be reviewable by governance

Emergency authority is corrective, not punitive.

9. Slashing & Governance Interaction

DEFAULT_ADMIN_ROLE cannot directly slash participants.

Instead:

It may trigger review workflows

It may escalate issues to governance or emergency committees

Slashing decisions are protocol-driven, not administrator-driven.

10. Threat Model

Primary risks involving DEFAULT_ADMIN_ROLE:

Key compromise

Governance capture

Malicious upgrade deployment

Mitigations:

Multisig custody

Timelocks

On-chain telemetry

Public upgrade events

11. Observability & Telemetry

All DEFAULT_ADMIN_ROLE actions MUST:

Emit structured, deterministic events

Be indexable by off-chain systems

Be compatible with cross-chain telemetry relays

Silence or non-emission is treated as misbehavior.

12. Best Practices

Minimum 3-of-5 multisig control

Mandatory upgrade timelocks

Regular key rotation

Continuous monitoring of admin actions

13. Out-of-Scope Authority

DEFAULT_ADMIN_ROLE does NOT have authority to:

Override consensus outcomes

Modify historical state

Alter immutable data

Bypass cryptographic guarantees

14. Compliance & Audit Readiness

This role definition is:

Hackathon compliant

Audit-ready

Governance-transparent

Production-aligned

15. Status

Role State: Active

Specification Version: v1.0

Change Control: DAO Governance

Last Review: Current
