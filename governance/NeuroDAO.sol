// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * NeuroDAO.sol
 * ------------------------------------------------------------------
 * Canonical governance layer for NeuroGrid.
 *
 * RESPONSIBILITIES
 * - Proposal creation and lifecycle tracking
 * - Voting with ABST governance token
 * - Deterministic governance telemetry
 * - Delegates execution to ProposalExecutor
 *
 * IMPORTANT
 * - THIS IS A FULL FILE REPLACEMENT
 * - Replace the entire contents of:
 *
 *   contracts/Governance/NeuroDAO.sol
 */

import "../Core/NeuroGridKernel.sol";
import "../Token/ABSToken.sol";
import "./ProposalExecutor.sol";

contract NeuroDAO {
    /*//////////////////////////////////////////////////////////////
                                TYPES
    //////////////////////////////////////////////////////////////*/

    enum ProposalState {
        NONE,
        ACTIVE,
        PASSED,
        EXECUTED,
        REJECTED
    }

    struct Proposal {
        uint256 id;
        address proposer;
        bytes32 descriptionHash;
        uint256 startEpoch;
        uint256 endEpoch;
        uint256 forVotes;
        uint256 againstVotes;
        ProposalState state;
        bool executed;
    }

    /*//////////////////////////////////////////////////////////////
                                STORAGE
    //////////////////////////////////////////////////////////////*/

    NeuroGridKernel public immutable kernel;
    ABSToken public immutable absToken;
    ProposalExecutor public executor;

    uint256 public proposalCount;

    mapping(uint256 => Proposal) private _proposals;
    mapping(uint256 => mapping(address => bool)) private _hasVoted;

    /*//////////////////////////////////////////////////////////////
                                EVENTS
    //////////////////////////////////////////////////////////////*/

    event ProposalCreated(
        uint256 indexed proposalId,
        address indexed proposer,
        bytes32 descriptionHash
    );

    event VoteCast(
        uint256 indexed proposalId,
        address indexed voter,
        bool support,
        uint256 weight
    );

    event ProposalFinalized(
        uint256 indexed proposalId,
        ProposalState state
    );

    /*//////////////////////////////////////////////////////////////
                                MODIFIERS
    //////////////////////////////////////////////////////////////*/

    modifier onlyTokenHolder() {
        require(absToken.balanceOf(msg.sender) > 0, "NO_VOTING_POWER");
        _;
    }

    modifier proposalExists(uint256 proposalId) {
        require(_proposals[proposalId].state != ProposalState.NONE, "INVALID_PROPOSAL");
        _;
    }

    /*//////////////////////////////////////////////////////////////
                                CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/

    constructor(
        address kernelAddress,
        address tokenAddress,
        address executorAddress
    ) {
        require(kernelAddress != address(0), "INVALID_KERNEL");
        require(tokenAddress != address(0), "INVALID_TOKEN");
        require(executorAddress != address(0), "INVALID_EXECUTOR");

        kernel = NeuroGridKernel(kernelAddress);
        absToken = ABSToken(tokenAddress);
        executor = ProposalExecutor(executorAddress);
    }

    /*//////////////////////////////////////////////////////////////
                        PROPOSAL LIFECYCLE
    //////////////////////////////////////////////////////////////*/

    function createProposal(
        bytes32 descriptionHash,
        uint256 votingDurationEpochs
    ) external onlyTokenHolder returns (uint256) {
        require(votingDurationEpochs > 0, "INVALID_DURATION");

        proposalCount++;
        uint256 id = proposalCount;

        uint256 start = kernel.currentEpoch();
        uint256 end = start + votingDurationEpochs;

        _proposals[id] = Proposal({
            id: id,
            proposer: msg.sender,
            descriptionHash: descriptionHash,
            startEpoch: start,
            endEpoch: end,
            forVotes: 0,
            againstVotes: 0,
            state: ProposalState.ACTIVE,
            executed: false
        });

        kernel.emitTelemetry(
            keccak256("NEURO_DAO"),
            keccak256("PROPOSAL_CREATED"),
            abi.encode(id, msg.sender)
        );

        emit ProposalCreated(id, msg.sender, descriptionHash);
        return id;
    }

    function vote(
        uint256 proposalId,
        bool support
    ) external proposalExists(proposalId) onlyTokenHolder {
        Proposal storage p = _proposals[proposalId];
        require(p.state == ProposalState.ACTIVE, "NOT_ACTIVE");
        require(!_hasVoted[proposalId][msg.sender], "ALREADY_VOTED");
        require(kernel.currentEpoch() <= p.endEpoch, "VOTING_ENDED");

        uint256 weight = absToken.balanceOf(msg.sender);
        require(weight > 0, "ZERO_WEIGHT");

        _hasVoted[proposalId][msg.sender] = true;

        if (support) {
            p.forVotes += weight;
        } else {
            p.againstVotes += weight;
        }

        kernel.emitTelemetry(
            keccak256("NEURO_DAO"),
            keccak256("VOTE_CAST"),
            abi.encode(proposalId, msg.sender, support, weight)
        );

        emit VoteCast(proposalId, msg.sender, support, weight);
    }

    function finalizeProposal(uint256 proposalId)
        external
        proposalExists(proposalId)
    {
        Proposal storage p = _proposals[proposalId];
        require(p.state == ProposalState.ACTIVE, "NOT_ACTIVE");
        require(kernel.currentEpoch() > p.endEpoch, "VOTING_ONGOING");

        if (p.forVotes > p.againstVotes) {
            p.state = ProposalState.PASSED;
        } else {
            p.state = ProposalState.REJECTED;
        }

        kernel.emitTelemetry(
            keccak256("NEURO_DAO"),
            keccak256("PROPOSAL_FINALIZED"),
            abi.encode(proposalId, p.state)
        );

        emit ProposalFinalized(proposalId, p.state);
    }

    function executeProposal(uint256 proposalId)
        external
        proposalExists(proposalId)
    {
        Proposal storage p = _proposals[proposalId];
        require(p.state == ProposalState.PASSED, "NOT_PASSED");
        require(!p.executed, "ALREADY_EXECUTED");

        p.executed = true;
        p.state = ProposalState.EXECUTED;

        executor.executeProposal(proposalId);

        kernel.emitTelemetry(
            keccak256("NEURO_DAO"),
            keccak256("PROPOSAL_EXECUTED"),
            abi.encode(proposalId)
        );

        emit ProposalFinalized(proposalId, ProposalState.EXECUTED);
    }

    /*//////////////////////////////////////////////////////////////
                            VIEW FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    function getProposal(uint256 proposalId)
        external
        view
        returns (Proposal memory)
    {
        return _proposals[proposalId];
    }

    function hasVoted(uint256 proposalId, address voter)
        external
        view
        returns (bool)
    {
        return _hasVoted[proposalId][voter];
    }
}
