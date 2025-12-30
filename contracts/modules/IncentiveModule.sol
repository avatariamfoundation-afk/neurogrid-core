// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * @title IncentiveModule
 * @author NeuroGrid
 * @notice CORE incentive signaling module (non-financial, non-tokenized).
 *
 * @dev CORE-ONLY MODULE
 * - NO token minting
 * - NO payments
 * - NO economic transfers
 * - Incentives are symbolic, reputational, and governance-linked
 *
 * This module exists to:
 * - Signal positive contribution
 * - Support off-chain rewards, grants, or acknowledgements
 * - Feed governance, reputation, and audit processes
 *
 * Any financial execution MUST occur off-chain or in external systems.
 */

import "@openzeppelin/contracts/access/AccessControl.sol";

contract IncentiveModule is AccessControl {
    /* =============================================================
                                ROLES
       ============================================================= */

    bytes32 public constant INCENTIVE_ADMIN_ROLE =
        keccak256("INCENTIVE_ADMIN_ROLE");

    bytes32 public constant INCENTIVE_ISSUER_ROLE =
        keccak256("INCENTIVE_ISSUER_ROLE");

    /* =============================================================
                            INCENTIVE STATE
       ============================================================= */

    struct IncentiveRecord {
        string incentiveType;        // e.g. RESEARCH_CONTRIBUTION / SAFETY_ACTION
        string description;          // Human-readable reason
        uint256 timestamp;
        address issuedBy;
        bool revoked;
    }

    uint256 public incentiveCount;
    mapping(uint256 => IncentiveRecord) private incentives;
    mapping(address => uint256[]) private incentivesByRecipient;

    /* =============================================================
                                EVENTS
       ============================================================= */

    event IncentiveIssued(
        uint256 indexed incentiveId,
        address indexed recipient,
        string incentiveType,
        address indexed issuedBy,
        uint256 timestamp
    );

    event IncentiveRevoked(
        uint256 indexed incentiveId,
        address indexed revokedBy,
        uint256 timestamp
    );

    /* =============================================================
                              CONSTRUCTOR
       ============================================================= */

    constructor(address admin) {
        _grantRole(DEFAULT_ADMIN_ROLE, admin);
        _grantRole(INCENTIVE_ADMIN_ROLE, admin);
    }

    /* =============================================================
                        INCENTIVE MANAGEMENT
       ============================================================= */

    /**
     * @notice Issue a non-financial incentive record
     */
    function issueIncentive(
        address recipient,
        string calldata incentiveType,
        string calldata description
    )
        external
        onlyRole(INCENTIVE_ISSUER_ROLE)
    {
        incentives[incentiveCount] = IncentiveRecord({
            incentiveType: incentiveType,
            description: description,
            timestamp: block.timestamp,
            issuedBy: msg.sender,
            revoked: false
        });

        incentivesByRecipient[recipient].push(incentiveCount);

        emit IncentiveIssued(
            incentiveCount,
            recipient,
            incentiveType,
            msg.sender,
            block.timestamp
        );

        incentiveCount++;
    }

    /**
     * @notice Revoke an issued incentive (audit or compliance correction)
     */
    function revokeIncentive(uint256 incentiveId)
        external
        onlyRole(INCENTIVE_ADMIN_ROLE)
    {
        incentives[incentiveId].revoked = true;

        emit IncentiveRevoked(
            incentiveId,
            msg.sender,
            block.timestamp
        );
    }

    /* =============================================================
                             VIEW FUNCTIONS
       ============================================================= */

    function getIncentive(uint256 incentiveId)
        external
        view
        returns (
            string memory incentiveType,
            string memory description,
            uint256 timestamp,
            address issuedBy,
            bool revoked
        )
    {
        IncentiveRecord memory record = incentives[incentiveId];
        return (
            record.incentiveType,
            record.description,
            record.timestamp,
            record.issuedBy,
            record.revoked
        );
    }

    function getIncentivesByRecipient(address recipient)
        external
        view
        returns (uint256[] memory)
    {
        return incentivesByRecipient[recipient];
    }

    /* =============================================================
                          ROLE MANAGEMENT
       ============================================================= */

    function grantIssuer(address account)
        external
        onlyRole(INCENTIVE_ADMIN_ROLE)
    {
        _grantRole(INCENTIVE_ISSUER_ROLE, account);
    }

    function revokeIssuer(address account)
        external
        onlyRole(INCENTIVE_ADMIN_ROLE)
    {
        _revokeRole(INCENTIVE_ISSUER_ROLE, account);
    }
}

