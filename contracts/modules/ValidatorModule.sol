// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * @title ValidatorModule
 * @author NeuroGrid
 * @notice Validation and attestation module bound to NeuroGridCore.
 *
 * @dev This module:
 * - Performs structured validation of off-chain artifacts
 * - Attests to integrity, completeness, and review status
 * - Anchors validation hashes into Core
 *
 * This module:
 * - DOES NOT execute logic
 * - DOES NOT modify Core state beyond anchoring
 * - DOES NOT enforce governance decisions
 */

interface INeuroGridCore {
    function anchorRegistryRecord(
        bytes32 recordHash,
        string calldata domain,
        string calldata recordType,
        bool emergencyFlag
    ) external;
}

contract ValidatorModule {
    /* =============================================================
                            CORE BINDING
       ============================================================= */

    INeuroGridCore public immutable core;

    /* =============================================================
                            DATA STRUCTURES
       ============================================================= */

    struct ValidationRecord {
        bytes32 artifactHash;
        string artifactDomain;      // CORE / DESCI / MEDINTEL
        string validationType;      // SAFETY / QUALITY / COMPLIANCE / PERFORMANCE
        bytes32 validatorSignature; // off-chain signer hash
        uint256 timestamp;
        address submittedBy;
    }

    uint256 public validationCount;
    mapping(uint256 => ValidationRecord) public validations;

    /* =============================================================
                                EVENTS
       ============================================================= */

    event ValidationSubmitted(
        uint256 indexed validationId,
        bytes32 artifactHash,
        string artifactDomain,
        string validationType,
        bytes32 validatorSignature,
        address indexed submittedBy
    );

    /* =============================================================
                              CONSTRUCTOR
       ============================================================= */

    constructor(address coreAddress) {
        require(coreAddress != address(0), "Invalid Core address");
        core = INeuroGridCore(coreAddress);
    }

    /* =============================================================
                         VALIDATION SUBMISSION
       ============================================================= */

    function submitValidation(
        bytes32 artifactHash,
        string calldata artifactDomain,
        string calldata validationType,
        bytes32 validatorSignature,
        bool emergencyFlag
    ) external {
        validations[validationCount] = ValidationRecord({
            artifactHash: artifactHash,
            artifactDomain: artifactDomain,
            validationType: validationType,
            validatorSignature: validatorSignature,
            timestamp: block.timestamp,
            submittedBy: msg.sender
        });

        emit ValidationSubmitted(
            validationCount,
            artifactHash,
            artifactDomain,
            validationType,
            validatorSignature,
            msg.sender
        );

        core.anchorRegistryRecord(
            keccak256(
                abi.encodePacked(
                    artifactHash,
                    artifactDomain,
                    validationType,
                    validatorSignature,
                    block.timestamp,
                    msg.sender
                )
            ),
            artifactDomain,
            "VALIDATION",
            emergencyFlag
        );

        validationCount++;
    }
}

