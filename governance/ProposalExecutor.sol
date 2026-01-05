// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * ProposalExecutor.sol
 * ------------------------------------------------------------------
 * Deterministic execution layer for NeuroDAO proposals.
 *
 * RESPONSIBILITIES
 * - Executes already-approved governance decisions
 * - Isolates execution logic from voting logic
 * - Emits deterministic telemetry via NeuroGridKernel
 *
 * IMPORTANT
 * - THIS IS A FULL FILE REPLACEMENT
 * - Replace the entire contents of:
 *
 *   contracts/Governance/ProposalExecutor.sol
 */

import "../Core/NeuroGridKernel.sol";

contract ProposalExecutor {
    /*//////////////////////////////////////////////////////////////
                                STORAGE
    //////////////////////////////////////////////////////////////*/

    NeuroGridKernel public immutable kernel;
    address public immutable dao;

    /*//////////////////////////////////////////////////////////////
                                EVENTS
    //////////////////////////////////////////////////////////////*/

    event ProposalExecuted(uint256 indexed proposalId);

    /*//////////////////////////////////////////////////////////////
                                MODIFIERS
    //////////////////////////////////////////////////////////////*/

    modifier onlyDAO() {
        require(msg.sender == dao, "ONLY_DAO");
        _;
    }

    /*//////////////////////////////////////////////////////////////
                              CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/

    constructor(address kernelAddress, address daoAddress) {
        require(kernelAddress != address(0), "INVALID_KERNEL");
        require(daoAddress != address(0), "INVALID_DAO");

        kernel = NeuroGridKernel(kernelAddress);
        dao = daoAddress;
    }

    /*//////////////////////////////////////////////////////////////
                        EXECUTION ENTRYPOINT
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Executes an already-passed proposal
     * @dev Execution logic is intentionally minimal and deterministic.
     *      Future upgrades may route execution through Kernel permissions.
     */
    function executeProposal(uint256 proposalId) external onlyDAO {
        // NOTE:
        // Actual execution payloads are intentionally abstracted.
        // This ensures governance decisions are auditable without
        // embedding arbitrary logic here.

        kernel.emitTelemetry(
            keccak256("PROPOSAL_EXECUTOR"),
            keccak256("EXECUTION_CONFIRMED"),
            abi.encode(proposalId)
        );

        emit ProposalExecuted(proposalId);
    }
}
