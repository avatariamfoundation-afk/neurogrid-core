// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * ComputeRegistry.sol
 * ------------------------------------------------------------------
 * Deterministic registry for compute nodes in the NeuroGrid network.
 *
 * RESPONSIBILITIES
 * - Register and deregister compute nodes
 * - Maintain deterministic state for node lifecycle
 * - Emit kernel-aligned telemetry
 * - Enforce validator-controlled permissions (no open registration)
 *
 * IMPORTANT
 * - THIS IS A FULL FILE REPLACEMENT
 * - Replace the entire contents of:
 *
 *   contracts/Core/ComputeRegistry.sol
 *
 * - This contract is READ-ONLY with respect to governance
 * - Governance / DAO logic lives elsewhere (by design)
 */

import "./NeuroGridKernel.sol";

contract ComputeRegistry {
    /*//////////////////////////////////////////////////////////////
                                TYPES
    //////////////////////////////////////////////////////////////*/

    enum NodeStatus {
        NONE,
        REGISTERED,
        SUSPENDED,
        REMOVED
    }

    struct ComputeNode {
        address operator;
        NodeStatus status;
        uint256 registeredEpoch;
        uint256 lastUpdateEpoch;
        bytes32 metadataHash;
    }

    /*//////////////////////////////////////////////////////////////
                                STORAGE
    //////////////////////////////////////////////////////////////*/

    /// @dev Reference to the NeuroGrid kernel (epoch + telemetry source)
    NeuroGridKernel public immutable kernel;

    /// @dev nodeId => ComputeNode
    mapping(bytes32 => ComputeNode) private _nodes;

    /// @dev operator address => nodeId
    mapping(address => bytes32) private _operatorToNode;

    /// @dev Total active registered nodes
    uint256 public activeNodeCount;

    /*//////////////////////////////////////////////////////////////
                                EVENTS
    //////////////////////////////////////////////////////////////*/

    event ComputeNodeRegistered(
        bytes32 indexed nodeId,
        address indexed operator,
        bytes32 metadataHash,
        uint256 epoch
    );

    event ComputeNodeStatusUpdated(
        bytes32 indexed nodeId,
        NodeStatus status,
        uint256 epoch
    );

    event ComputeNodeRemoved(
        bytes32 indexed nodeId,
        uint256 epoch
    );

    /*//////////////////////////////////////////////////////////////
                                MODIFIERS
    //////////////////////////////////////////////////////////////*/

    modifier onlyKernelOwner() {
        require(msg.sender == kernel.owner(), "NOT_KERNEL_OWNER");
        _;
    }

    /*//////////////////////////////////////////////////////////////
                                CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/

    constructor(address kernelAddress) {
        require(kernelAddress != address(0), "INVALID_KERNEL");
        kernel = NeuroGridKernel(kernelAddress);
    }

    /*//////////////////////////////////////////////////////////////
                        NODE REGISTRATION
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Register a compute node
     * @dev Permissioned via kernel owner / governance executor
     */
    function registerNode(
        address operator,
        bytes32 metadataHash
    ) external onlyKernelOwner returns (bytes32 nodeId) {
        require(operator != address(0), "INVALID_OPERATOR");
        require(_operatorToNode[operator] == bytes32(0), "OPERATOR_EXISTS");

        nodeId = keccak256(
            abi.encodePacked(
                operator,
                block.chainid,
                kernel.currentEpoch()
            )
        );

        ComputeNode storage node = _nodes[nodeId];
        require(node.status == NodeStatus.NONE, "NODE_EXISTS");

        uint256 epoch = kernel.currentEpoch();

        _nodes[nodeId] = ComputeNode({
            operator: operator,
            status: NodeStatus.REGISTERED,
            registeredEpoch: epoch,
            lastUpdateEpoch: epoch,
            metadataHash: metadataHash
        });

        _operatorToNode[operator] = nodeId;
        activeNodeCount += 1;

        kernel.emitTelemetry(
            keccak256("COMPUTE_REGISTRY"),
            keccak256("NODE_REGISTERED"),
            abi.encode(nodeId, operator, metadataHash)
        );

        emit ComputeNodeRegistered(nodeId, operator, metadataHash, epoch);
    }

    /*//////////////////////////////////////////////////////////////
                        NODE MANAGEMENT
    //////////////////////////////////////////////////////////////*/

    function updateNodeStatus(
        bytes32 nodeId,
        NodeStatus newStatus
    ) external onlyKernelOwner {
        ComputeNode storage node = _nodes[nodeId];
        require(node.status != NodeStatus.NONE, "NODE_NOT_FOUND");

        uint256 epoch = kernel.currentEpoch();

        // Adjust active count deterministically
        if (node.status == NodeStatus.REGISTERED && newStatus != NodeStatus.REGISTERED) {
            activeNodeCount -= 1;
        } else if (node.status != NodeStatus.REGISTERED && newStatus == NodeStatus.REGISTERED) {
            activeNodeCount += 1;
        }

        node.status = newStatus;
        node.lastUpdateEpoch = epoch;

        kernel.emitTelemetry(
            keccak256("COMPUTE_REGISTRY"),
            keccak256("NODE_STATUS_UPDATED"),
            abi.encode(nodeId, newStatus)
        );

        emit ComputeNodeStatusUpdated(nodeId, newStatus, epoch);
    }

    function removeNode(bytes32 nodeId) external onlyKernelOwner {
        ComputeNode storage node = _nodes[nodeId];
        require(node.status != NodeStatus.NONE, "NODE_NOT_FOUND");

        uint256 epoch = kernel.currentEpoch();

        if (node.status == NodeStatus.REGISTERED) {
            activeNodeCount -= 1;
        }

        delete _operatorToNode[node.operator];
        node.status = NodeStatus.REMOVED;
        node.lastUpdateEpoch = epoch;

        kernel.emitTelemetry(
            keccak256("COMPUTE_REGISTRY"),
            keccak256("NODE_REMOVED"),
            abi.encode(nodeId)
        );

        emit ComputeNodeRemoved(nodeId, epoch);
    }

    /*//////////////////////////////////////////////////////////////
                            VIEW FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    function getNode(bytes32 nodeId) external view returns (ComputeNode memory) {
        return _nodes[nodeId];
    }

    function getNodeByOperator(address operator) external view returns (ComputeNode memory) {
        bytes32 nodeId = _operatorToNode[operator];
        require(nodeId != bytes32(0), "NODE_NOT_FOUND");
        return _nodes[nodeId];
    }

    function nodeIdOf(address operator) external view returns (bytes32) {
        return _operatorToNode[operator];
    }
}
