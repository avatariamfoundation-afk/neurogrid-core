// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "../Kernel/NeuroGridKernel.sol";

/**
 * @title NeuroDAO
 * @author NeuroGrid
 * @notice Minimal, execution-focused DAO for protocol-level governance.
 *
 * DESIGN INTENT
 * -------------
 * - Governance lives in /Governance (clean separation, as requested)
 * - DAO ONLY handles proposal lifecycle and voting
 * - NO execution logic here (delegated to ProposalExecutor)
 * - Kernel remains the ultimate source of truth
 *
 * HACKATHON + REAL-WORLD BALANCE
 * ------------------------------
 * - Lightweight voting (token-less, address-based)
 * - Deterministic, auditable, and extensible
 * - Designed to be upgraded post-hackathon
 */

contract NeuroDAO {

    /*//////////////////////////////////////////////////////////////
                                ERRORS
    //////////////////////////////////////////////////////////////*/

    error NotKernelAdmin();
    error ProposalNotFound();
    error VotingClosed();
    error AlreadyVoted();
    error InvalidDuration();
    error KernelInactive();

    /*//////////////////////////////////////////////////////////////
                                EVENTS
    //////////////////////////////////////////////////////////////*/

    event ProposalCreated(
        uint256 indexed proposalId,
        address indexed proposer,
        string description,
        uint256 startTime,
        uint256 endTime
    );

    event VoteCast(
        uint256 indexed proposalId,
        address indexed voter,
        bool support
    );

    event ProposalFinalized(
        uint256 indexed proposalId,
        bool approved
    );

    /*//////////////////////////////////////////////////////////////
                                STRUCTS
    //////////////////////////////////////////////////////////////*/

    struct Proposal {
        address proposer;
        string description;
        uint256 startTime;
        uint256 endTime;
        uint256 votesFor;
        uint256 votesAgainst;
        bool finalized;
        bool approved;
    }

    /*//////////////////////////////////////////////////////////////
                            STORAGE VARIABLES
    //////////////////////////////////////////////////////////////*/

    NeuroGridKernel public immutable kernel;

    uint256 public proposalCount;

    mapping(uint256 => Proposal) private proposals;
    mapping(uint256 => mapping(address => bool)) private hasVoted;

    /*//////////////////////////////////////////////////////////////
                                MODIFIERS
    //////////////////////////////////////////////////////////////*/

    modifier kernelActive() {
        if (!kernel.isActive()) revert KernelInactive();
        _;
    }

    /*//////////////////////////////////////////////////////////////
                                CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/

    constructor(address kernelAddress) {
        kernel = NeuroGridKernel(kernelAddress);
    }

    /*//////////////////////////////////////////////////////////////
                        PROPOSAL MANAGEMENT
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Create a governance proposal.
     *
     * @param description Human-readable proposal summary
     * @param votingDuration Duration in seconds
     */
    function createProposal(
        string calldata description,
        uint256 votingDuration
    ) external kernelActive returns (uint256) {
        if (votingDuration == 0) revert InvalidDuration();

        uint256 proposalId = ++proposalCount;

        proposals[proposalId] = Proposal({
            proposer: msg.sender,
            description: description,
            startTime: block.timestamp,
            endTime: block.timestamp + votingDuration,
            votesFor: 0,
            votesAgainst: 0,
            finalized: false,
            approved: false
        });

        emit ProposalCreated(
            proposalId,
            msg.sender,
            description,
            block.timestamp,
            block.timestamp + votingDuration
        );

        return proposalId;
    }

    /**
     * @notice Vote on an active proposal.
     *
     * @param proposalId Target proposal
     * @param support True = For, False = Against
     */
    function vote(
        uint256 proposalId,
        bool support
    ) external kernelActive {
        Proposal storage proposal = proposals[proposalId];
        if (proposal.startTime == 0) revert ProposalNotFound();
        if (block.timestamp > proposal.endTime) revert VotingClosed();
        if (hasVoted[proposalId][msg.sender]) revert AlreadyVoted();

        hasVoted[proposalId][msg.sender] = true;

        if (support) {
            proposal.votesFor++;
        } else {
            proposal.votesAgainst++;
        }

        emit VoteCast(proposalId, msg.sender, support);
    }

    /**
     * @notice Finalize a proposal after voting period.
     * @dev Does NOT execute anything. Only marks outcome.
     */
    function finalizeProposal(uint256 proposalId) external kernelActive {
        Proposal storage proposal = proposals[proposalId];
        if (proposal.startTime == 0) revert ProposalNotFound();
        if (block.timestamp <= proposal.endTime) revert VotingClosed();
        if (proposal.finalized) return;

        proposal.finalized = true;
        proposal.approved = proposal.votesFor > proposal.votesAgainst;

        emit ProposalFinalized(proposalId, proposal.approved);
    }

    /*//////////////////////////////////////////////////////////////
                        VIEW FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    function getProposal(uint256 proposalId)
        external
        view
        returns (Proposal memory)
    {
        Proposal memory proposal = proposals[proposalId];
        if (proposal.startTime == 0) revert ProposalNotFound();
        return proposal;
    }

    function hasAddressVoted(
        uint256 proposalId,
        address voter
    ) external view returns (bool) {
        return hasVoted[proposalId][voter];
    }

    /*//////////////////////////////////////////////////////////////
                        STORAGE GAP
    //////////////////////////////////////////////////////////////*/

    uint256[50] private __gap;
}

