// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * @title NeuroGridCore
 * @author NeuroGrid
 * @notice Registry-only Core contract for integrity anchoring, cross-linking,
 *         emergency signaling, and audit traceability.
 *
 * @dev This contract is deliberately inert:
 * - NO token logic
 * - NO task execution
 * - NO clinical logic
 * - NO governance voting
 *
 * It exists solely as a cryptographic and authority-bound anchor.
 */

import "@openzeppelin/contracts/access/AccessControl.sol";

contract NeuroGridCore is AccessControl {
    /* =============================================================
                                ROLES
       ============================================================= */

    bytes32 public constant GOVERNANCE_ROLE = keccak256("GOVERNANCE_ROLE");
    bytes32 public constant SAFETY_COUNCIL_ROLE = keccak256("SAFETY_COUNCIL_ROLE");
    bytes32 public constant REGISTRY_WRITER_ROLE = keccak256("REGISTRY_WRITER_ROLE");

    /* =============================================================
                             REGISTRY STATE
       ============================================================= */

    struct RegistryRecord {
        bytes32 recordHash;
        string domain;          // CORE / DESCI / MEDINTEL
        string recordType;      // GOVERNANCE / SAFETY / AUDIT / EMERGENCY / RESEARCH
        uint256 timestamp;
        address submittedBy;
        bool emergencyFlag;
    }

    uint256 public recordCount;
    mapping(uint256 => RegistryRecord) public registry;

    /* =============================================================
                             CROSS-LINK STATE
       ============================================================= */

    struct CrossLinkRecord {
        bytes32 sourceHash;
        string sourceDomain;
        bytes32 targetHash;
        string targetDomain;
        string linkType;        // GOVERNANCE_REFERENCE / SAFETY_ESCALATION / AUDIT_TRACE / etc.
        uint256 timestamp;
        address submittedBy;
        bool emergencyFlag;
    }

    uint256 public crossLinkCount;
    mapping(uint256 => CrossLinkRecord) public crossLinks;

    /* =============================================================
                                EVENTS
       ============================================================= */

    event RegistryAnchored(
        uint256 indexed recordId,
        bytes32 recordHash,
        string domain,
        string recordType,
        bool emergencyFlag,
        address indexed submittedBy
    );

    event CrossLinkAnchored(
        uint256 indexed crossLinkId,
        bytes32 sourceHash,
        string sourceDomain,
        bytes32 targetHash,
        string targetDomain,
        string linkType,
        bool emergencyFlag,
        address indexed submittedBy
    );

    event EmergencyDeclared(address indexed by, uint256 timestamp);
    event EmergencyCleared(address indexed by, uint256 timestamp);

    /* =============================================================
                          EMERGENCY STATE
       ============================================================= */

    bool public emergencyActive;

    /* =============================================================
                              CONSTRUCTOR
       ============================================================= */

    constructor(address admin) {
        _grantRole(DEFAULT_ADMIN_ROLE, admin);
        _grantRole(GOVERNANCE_ROLE, admin);
    }

    /* =============================================================
                        REGISTRY ANCHORING
       ============================================================= */

    function anchorRegistryRecord(
        bytes32 recordHash,
        string calldata domain,
        string calldata recordType,
        bool emergencyFlag
    ) external onlyRole(REGISTRY_WRITER_ROLE) {
        registry[recordCount] = RegistryRecord({
            recordHash: recordHash,
            domain: domain,
            recordType: recordType,
            timestamp: block.timestamp,
            submittedBy: msg.sender,
            emergencyFlag: emergencyFlag
        });

        emit RegistryAnchored(
            recordCount,
            recordHash,
            domain,
            recordType,
            emergencyFlag,
            msg.sender
        );

        recordCount++;
    }

    /* =============================================================
                        CROSS-LINK ANCHORING
       ============================================================= */

    function anchorCrossLink(
        bytes32 sourceHash,
        string calldata sourceDomain,
        bytes32 targetHash,
        string calldata targetDomain,
        string calldata linkType,
        bool emergencyFlag
    ) external onlyRole(REGISTRY_WRITER_ROLE) {
        crossLinks[crossLinkCount] = CrossLinkRecord({
            sourceHash: sourceHash,
            sourceDomain: sourceDomain,
            targetHash: targetHash,
            targetDomain: targetDomain,
            linkType: linkType,
            timestamp: block.timestamp,
            submittedBy: msg.sender,
            emergencyFlag: emergencyFlag
        });

        emit CrossLinkAnchored(
            crossLinkCount,
            sourceHash,
            sourceDomain,
            targetHash,
            targetDomain,
            linkType,
            emergencyFlag,
            msg.sender
        );

        crossLinkCount++;
    }

    /* =============================================================
                        EMERGENCY CONTROLS
       ============================================================= */

    function declareEmergency() external onlyRole(SAFETY_COUNCIL_ROLE) {
        emergencyActive = true;
        emit EmergencyDeclared(msg.sender, block.timestamp);
    }

    function clearEmergency() external onlyRole(GOVERNANCE_ROLE) {
        emergencyActive = false;
        emit EmergencyCleared(msg.sender, block.timestamp);
    }

    /* =============================================================
                         ROLE MANAGEMENT
       ============================================================= */

    function grantRegistryWriter(address account)
        external
        onlyRole(GOVERNANCE_ROLE)
    {
        _grantRole(REGISTRY_WRITER_ROLE, account);
    }

    function revokeRegistryWriter(address account)
        external
        onlyRole(GOVERNANCE_ROLE)
    {
        _revokeRole(REGISTRY_WRITER_ROLE, account);
    }
}

