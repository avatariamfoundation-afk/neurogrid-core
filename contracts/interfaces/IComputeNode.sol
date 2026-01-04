// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * @title IComputeNode
 * @author Aethera BioSync / NeuroGrid
 *
 * PURPOSE
 * -------
 * Canonical interface for off-chain compute providers (AI inference,
 * analytics, simulations) that interact with NeuroGrid on-chain registries.
 *
 * This interface:
 * - Defines how compute nodes identify themselves
 * - Defines how results are committed on-chain
 * - Enforces a clean boundary between off-chain compute and on-chain truth
 *
 * DESIGN PRINCIPLES
 * -----------------
 * - Interface-only (NO logic)
 * - Deterministic inputs / outputs
 * - Auditable by judges and future auditors
 * - Compatible with DeSci, MedIntel, and Kernel layers
 *
 * HACKATHON SAFE
 * -------------
 * - Minimal surface
 * - No external dependencies
 * - Clear semantics
 */

interface IComputeNode {

    /*//////////////////////////////////////////////////////////////
                                TYPES
    //////////////////////////////////////////////////////////////*/

    enum ComputeStatus {
        UNKNOWN,
        REGISTERED,
        ACTIVE,
        SUSPENDED
    }

    /*//////////////////////////////////////////////////////////////
                                EVENTS
    //////////////////////////////////////////////////////////////*/

    event ComputeNodeRegistered(
        address indexed node,
        string metadataURI
    );

    event ComputeResultSubmitted(
        address indexed node,
        bytes32 indexed jobId,
        bytes32 resultHash
    );

    /*//////////////////////////////////////////////////////////////
                            NODE IDENTITY
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Returns the current status of a compute node
     */
    function computeNodeStatus(address node)
        external
        view
        returns (ComputeStatus);

    /**
     * @notice Returns metadata URI describing the node
     * @dev Points to off-chain JSON (capabilities, model type, region, etc.)
     */
    function computeNodeMetadata(address node)
        external
        view
        returns (string memory);

    /*//////////////////////////////////////////////////////////////
                        REGISTRATION / LIFECYCLE
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Register a compute node
     * @param metadataURI Off-chain description of compute capabilities
     */
    function registerComputeNode(string calldata metadataURI) external;

    /**
     * @notice Suspend a compute node (governance / kernel action)
     */
    function suspendComputeNode(address node) external;

    /*//////////////////////////////////////////////////////////////
                        COMPUTE RESULT COMMIT
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Submit the hash of an off-chain compute result
     * @dev Raw data NEVER stored on-chain
     *
     * @param jobId Deterministic job identifier
     * @param resultHash Hash of result payload (IPFS / Arweave / S3)
     */
    function submitComputeResult(
        bytes32 jobId,
        bytes32 resultHash
    ) external;
}

