// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title IComputeNode
/// @notice Canonical interface for all registered compute nodes
/// @dev Enforced by ComputeRegistry, ValidatorManager, and ProposalExecutor
interface IComputeNode {

    /*//////////////////////////////////////////////////////////////
                                EVENTS
    //////////////////////////////////////////////////////////////*/

    /// @notice Emitted when a compute task begins execution
    event ComputeStarted(
        address indexed node,
        bytes32 indexed taskId,
        uint256 timestamp
    );

    /// @notice Emitted when a compute task completes successfully
    event ComputeCompleted(
        address indexed node,
        bytes32 indexed taskId,
        bytes32 resultHash,
        uint256 timestamp
    );

    /// @notice Emitted when a compute task fails
    event ComputeFailed(
        address indexed node,
        bytes32 indexed taskId,
        string reason,
        uint256 timestamp
    );

    /*//////////////////////////////////////////////////////////////
                            READ FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    /// @notice Returns whether the node is currently active
    function isActive() external view returns (bool);

    /// @notice Returns the node operator address
    function operator() external view returns (address);

    /// @notice Returns the last executed task ID
    function lastTaskId() external view returns (bytes32);

    /*//////////////////////////////////////////////////////////////
                        EXECUTION FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    /// @notice Called by authorized executors to begin computation
    /// @param taskId Deterministic task identifier
    /// @param payload Arbitrary compute payload hash or pointer
    function startCompute(
        bytes32 taskId,
        bytes calldata payload
    ) external;

    /// @notice Finalizes a compute task with deterministic output
    /// @param taskId Deterministic task identifier
    /// @param resultHash Hash of the compute output
    function finalizeCompute(
        bytes32 taskId,
        bytes32 resultHash
    ) external;

    /// @notice Aborts a compute task with a reason
    /// @param taskId Deterministic task identifier
    /// @param reason Human-readable failure reason
    function abortCompute(
        bytes32 taskId,
        string calldata reason
    ) external;
}
