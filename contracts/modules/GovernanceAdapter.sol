// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * @title GovernanceAdapter
 * @author NeuroGrid
 * @notice Controlled execution adapter between off-chain / DAO governance
 *         resolutions and the NeuroGridCore contract.
 *
 * @dev CORE-ONLY MODULE
 * - Executes ONLY pre-approved governance outcomes
 * - Does NOT perform voting
 * - Does NOT validate governance processes
 * - Assumes decisions are finalized off-chain or in DAO layers
 *
 * This contract is intentionally narrow to reduce blast radius.
 */

import "@openzeppelin/contracts/access/AccessControl.sol";

interface INeuroGridCore {
    function grantRegistryWriter(address account) external;
    function revokeRegistryWriter(address account) external;
    function declareEmergency() external;
    function clearEmergency() external;
}

contract GovernanceAdapter is AccessControl {
    /* =============================================================
                                ROLES
       ============================================================= */

    bytes32 public constant GOVERNANCE_EXECUTOR_ROLE =
        keccak256("GOVERNANCE_EXECUTOR_ROLE");

    /* =============================================================
                             CORE REFERENCE
       ============================================================= */

    INeuroGridCore public immutable core;

    /* =============================================================
                                EVENTS
       ============================================================= */

    event GovernanceActionExecuted(
        string actionType,
        address indexed target,
        address indexed executedBy,
        uint256 timestamp
    );

    /* =============================================================
                              CONSTRUCTOR
       ============================================================= */

    constructor(address admin, address coreAddress) {
        require(coreAddress != address(0), "Invalid core address");

        core = INeuroGridCore(coreAddress);

        _grantRole(DEFAULT_ADMIN_ROLE, admin);
        _grantRole(GOVERNANCE_EXECUTOR_ROLE, admin);
    }

    /* =============================================================
                        GOVERNANCE EXECUTION
       ============================================================= */

    /**
     * @notice Grants REGISTRY_WRITER_ROLE in Core
     * @dev Requires finalized governance approval off-chain
     */
    function executeGrantRegistryWriter(address account)
        external
        onlyRole(GOVERNANCE_EXECUTOR_ROLE)
    {
        core.grantRegistryWriter(account);

        emit GovernanceActionExecuted(
            "GRANT_REGISTRY_WRITER",
            account,
            msg.sender,
            block.timestamp
        );
    }

    /**
     * @notice Revokes REGISTRY_WRITER_ROLE in Core
     * @dev Requires finalized governance approval off-chain
     */
    function executeRevokeRegistryWriter(address account)
        external
        onlyRole(GOVERNANCE_EXECUTOR_ROLE)
    {
        core.revokeRegistryWriter(account);

        emit GovernanceActionExecuted(
            "REVOKE_REGISTRY_WRITER",
            account,
            msg.sender,
            block.timestamp
        );
    }

    /**
     * @notice Declares emergency state in Core
     * @dev Emergency authority must be defined off-chain
     */
    function executeDeclareEmergency()
        external
        onlyRole(GOVERNANCE_EXECUTOR_ROLE)
    {
        core.declareEmergency();

        emit GovernanceActionExecuted(
            "DECLARE_EMERGENCY",
            address(core),
            msg.sender,
            block.timestamp
        );
    }

    /**
     * @notice Clears emergency state in Core
     * @dev Requires governance ratification
     */
    function executeClearEmergency()
        external
        onlyRole(GOVERNANCE_EXECUTOR_ROLE)
    {
        core.clearEmergency();

        emit GovernanceActionExecuted(
            "CLEAR_EMERGENCY",
            address(core),
            msg.sender,
            block.timestamp
        );
    }
}

