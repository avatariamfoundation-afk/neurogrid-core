// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * @title ReputationModule
 * @author NeuroGrid
 * @notice CORE reputation tracking module for governance, research, and safety accountability.
 *
 * @dev CORE-ONLY MODULE
 * - NO token economics
 * - NO financial value
 * - NO voting logic
 * - Reputation is non-transferable, non-tradable, and role-scoped
 *
 * Reputation exists solely to:
 * - Signal trustworthiness
 * - Weight off-chain governance processes
 * - Support audit, safety, and compliance decisions
 */

import "@openzeppelin/contracts/access/AccessControl.sol";

contract ReputationModule is AccessControl {
    /* =============================================================
                                ROLES
       ============================================================= */

    bytes32 public constant REPUTATION_ADMIN_ROLE =
        keccak256("REPUTATION_ADMIN_ROLE");

    bytes32 public constant REPUTATION_UPDATER_ROLE =
        keccak256("REPUTATION_UPDATER_ROLE");

    /* =============================================================
                           REPUTATION STATE
       ============================================================= */

    struct ReputationRecord {
        uint256 score;              // Abstract reputation score (no units)
        uint256 lastUpdated;
        bool suspended;             // Safety or compliance suspension
    }

    mapping(address => ReputationRecord) private reputations;

    /* =============================================================
                                EVENTS
       ============================================================= */

    event ReputationUpdated(
        address indexed subject,
        uint256 previousScore,
        uint256 newScore,
        address indexed updatedBy,
        uint256 timestamp
    );

    event ReputationSuspended(
        address indexed subject,
        address indexed by,
        uint256 timestamp
    );

    event ReputationRestored(
        address indexed subject,
        address indexed by,
        uint256 timestamp
    );

    /* =============================================================
                              CONSTRUCTOR
       ============================================================= */

    constructor(address admin) {
        _grantRole(DEFAULT_ADMIN_ROLE, admin);
        _grantRole(REPUTATION_ADMIN_ROLE, admin);
    }

    /* =============================================================
                        REPUTATION MANAGEMENT
       ============================================================= */

    /**
     * @notice Set or update reputation score
     * @dev Score semantics are defined off-chain
     */
    function updateReputation(address subject, uint256 newScore)
        external
        onlyRole(REPUTATION_UPDATER_ROLE)
    {
        ReputationRecord storage record = reputations[subject];

        uint256 previous = record.score;
        record.score = newScore;
        record.lastUpdated = block.timestamp;

        emit ReputationUpdated(
            subject,
            previous,
            newScore,
            msg.sender,
            block.timestamp
        );
    }

    /**
     * @notice Suspend reputation due to safety, ethics, or compliance issue
     */
    function suspendReputation(address subject)
        external
        onlyRole(REPUTATION_ADMIN_ROLE)
    {
        reputations[subject].suspended = true;

        emit ReputationSuspended(
            subject,
            msg.sender,
            block.timestamp
        );
    }

    /**
     * @notice Restore suspended reputation
     */
    function restoreReputation(address subject)
        external
        onlyRole(REPUTATION_ADMIN_ROLE)
    {
        reputations[subject].suspended = false;
        reputations[subject].lastUpdated = block.timestamp;

        emit ReputationRestored(
            subject,
            msg.sender,
            block.timestamp
        );
    }

    /* =============================================================
                             VIEW FUNCTIONS
       ============================================================= */

    function getReputation(address subject)
        external
        view
        returns (
            uint256 score,
            uint256 lastUpdated,
            bool suspended
        )
    {
        ReputationRecord memory record = reputations[subject];
        return (record.score, record.lastUpdated, record.suspended);
    }

    /* =============================================================
                          ROLE MANAGEMENT
       ============================================================= */

    function grantUpdater(address account)
        external
        onlyRole(REPUTATION_ADMIN_ROLE)
    {
        _grantRole(REPUTATION_UPDATER_ROLE, account);
    }

    function revokeUpdater(address account)
        external
        onlyRole(REPUTATION_ADMIN_ROLE)
    {
        _revokeRole(REPUTATION_UPDATER_ROLE, account);
    }
}

