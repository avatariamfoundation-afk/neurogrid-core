// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "../Kernel/NeuroGridKernel.sol";
import "./NeuroDAO.sol";

/**
 * @title ProposalExecutor
 * @author NeuroGrid
 * @notice Deterministic execution layer for approved DAO proposals.
 *
 * EXECUTION PHILOSOPHY
 * --------------------
 * - DAO decides (vote + approval)
 * - Executor executes (state changes)
 * - Kernel authorizes (ultimate control plane)
 *
 * This separation:
 * - Reduces governance attack surface
 * - Keeps execution auditable
 * - Enables future upgrade paths (timelocks, multisig, modules)
 *
 * HACKATHON-READY
 * ----------------
 * - Minimal but real execution logic
 * - No complex timelocks (can be added later)
 * - Explicit allowlist of executable actions
 */

contract ProposalExecutor {

    /*//////////////////////////////////////////////////////////////
                                ERRORS
    //////////////////////////////////////////////////////////////*/

    error NotKernelAdmin();
    error ProposalNotApproved();
    error ProposalAlreadyExecuted();
    error InvalidTarget();
    error KernelInactive();

    /*//////////////////////////////////////////////////////////////
                                EVENTS
    //////////////////////////////////////////////////////////////*/

    event ProposalExecuted(
        uint256 indexed proposalId,
        address indexed target,
        bytes data
    );

    /*//////////////////////////////////////////////////////////////
                                STORAGE
    //////////////////////////////////////////////////////////////*/

    NeuroGridKernel public immutable kernel;
    NeuroDAO public immutable dao;

    mapping(uint256 => bool) public executed;

    /*//////////////////////////////////////////////////////////////
                                MODIFIERS
    //////////////////////////////////////////////////////////////*/

    modifier onlyKernelAdmin() {
        if (!kernel.isAdmin(msg.sender)) revert NotKernelAdmin();
        _;
    }

    modifier kernelActive() {
        if (!kernel.isActive()) revert KernelInactive();
        _;
    }

    /*//////////////////////////////////////////////////////////////
                                CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/

    constructor(address kernelAddress, address daoAddress) {
        kernel = NeuroGridKernel(kernelAddress);
        dao = NeuroDAO(daoAddress);
    }

    /*//////////////////////////////////////////////////////////////
                        EXECUTION LOGIC
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Execute an approved proposal.
     *
     * @dev
     * - Proposal must be finalized + approved in DAO
     * - Execution must be idempotent (single-run)
     * - Target MUST be registered in Kernel
     *
     * @param proposalId DAO proposal ID
     * @param target Contract address to call
     * @param data Encoded function call
     */
    function executeProposal(
        uint256 proposalId,
        address target,
        bytes calldata data
    )
        external
        kernelActive
        onlyKernelAdmin
    {
        if (executed[proposalId]) revert ProposalAlreadyExecuted();

        (
            ,
            ,
            ,
            ,
            ,
            ,
            bool finalized,
            bool approved
        ) = dao.getProposal(proposalId);

        if (!finalized || !approved) revert ProposalNotApproved();
        if (!kernel.isRegisteredModule(target)) revert InvalidTarget();

        executed[proposalId] = true;

        (bool success, ) = target.call(data);
        require(success, "EXECUTION_FAILED");

        emit ProposalExecuted(proposalId, target, data);
    }

    /*//////////////////////////////////////////////////////////////
                        VIEW HELPERS
    //////////////////////////////////////////////////////////////*/

    function isExecuted(uint256 proposalId) external view returns (bool) {
        return executed[proposalId];
    }

    /*//////////////////////////////////////////////////////////////
                        STORAGE GAP
    //////////////////////////////////////////////////////////////*/

    uint256[50] private __gap;
}

