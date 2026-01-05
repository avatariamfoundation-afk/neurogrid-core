// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * ArtifactRegistry.sol
 * ------------------------------------------------------------------
 * Deterministic registry for artifacts produced by compute nodes
 * in the NeuroGrid network.
 *
 * RESPONSIBILITIES
 * - Register AI / research artifacts
 * - Enforce deterministic ownership and provenance
 * - Maintain immutable artifact hashes
 * - Emit kernel-aligned telemetry
 *
 * IMPORTANT
 * - THIS IS A FULL FILE REPLACEMENT
 * - Replace the entire contents of:
 *
 *   contracts/Core/ArtifactRegistry.sol
 */

import "./NeuroGridKernel.sol";

contract ArtifactRegistry {
    /*//////////////////////////////////////////////////////////////
                                TYPES
    //////////////////////////////////////////////////////////////*/

    enum ArtifactStatus {
        NONE,
        REGISTERED,
        REVOKED
    }

    struct Artifact {
        bytes32 artifactId;
        bytes32 contentHash;
        address producer;
        uint256 createdEpoch;
        ArtifactStatus status;
    }

    /*//////////////////////////////////////////////////////////////
                                STORAGE
    //////////////////////////////////////////////////////////////*/

    /// @dev Reference to kernel for epochs + telemetry
    NeuroGridKernel public immutable kernel;

    /// @dev artifactId => Artifact
    mapping(bytes32 => Artifact) private _artifacts;

    /// @dev producer => list of artifactIds
    mapping(address => bytes32[]) private _producerArtifacts;

    /// @dev Total registered artifacts
    uint256 public totalArtifacts;

    /*//////////////////////////////////////////////////////////////
                                EVENTS
    //////////////////////////////////////////////////////////////*/

    event ArtifactRegistered(
        bytes32 indexed artifactId,
        bytes32 indexed contentHash,
        address indexed producer,
        uint256 epoch
    );

    event ArtifactRevoked(
        bytes32 indexed artifactId,
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
                        ARTIFACT REGISTRATION
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Register a new artifact
     * @dev Called by kernel / executor after validation
     */
    function registerArtifact(
        bytes32 contentHash,
        address producer
    ) external onlyKernelOwner returns (bytes32 artifactId) {
        require(contentHash != bytes32(0), "INVALID_HASH");
        require(producer != address(0), "INVALID_PRODUCER");

        artifactId = keccak256(
            abi.encodePacked(
                contentHash,
                producer,
                block.chainid,
                kernel.currentEpoch()
            )
        );

        Artifact storage artifact = _artifacts[artifactId];
        require(artifact.status == ArtifactStatus.NONE, "ARTIFACT_EXISTS");

        uint256 epoch = kernel.currentEpoch();

        _artifacts[artifactId] = Artifact({
            artifactId: artifactId,
            contentHash: contentHash,
            producer: producer,
            createdEpoch: epoch,
            status: ArtifactStatus.REGISTERED
        });

        _producerArtifacts[producer].push(artifactId);
        totalArtifacts += 1;

        kernel.emitTelemetry(
            keccak256("ARTIFACT_REGISTRY"),
            keccak256("ARTIFACT_REGISTERED"),
            abi.encode(artifactId, contentHash, producer)
        );

        emit ArtifactRegistered(artifactId, contentHash, producer, epoch);
    }

    /*//////////////////////////////////////////////////////////////
                        ARTIFACT MANAGEMENT
    //////////////////////////////////////////////////////////////*/

    function revokeArtifact(bytes32 artifactId) external onlyKernelOwner {
        Artifact storage artifact = _artifacts[artifactId];
        require(artifact.status == ArtifactStatus.REGISTERED, "INVALID_STATUS");

        artifact.status = ArtifactStatus.REVOKED;

        uint256 epoch = kernel.currentEpoch();

        kernel.emitTelemetry(
            keccak256("ARTIFACT_REGISTRY"),
            keccak256("ARTIFACT_REVOKED"),
            abi.encode(artifactId)
        );

        emit ArtifactRevoked(artifactId, epoch);
    }

    /*//////////////////////////////////////////////////////////////
                            VIEW FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    function getArtifact(bytes32 artifactId) external view returns (Artifact memory) {
        return _artifacts[artifactId];
    }

    function artifactsByProducer(address producer) external view returns (bytes32[] memory) {
        return _producerArtifacts[producer];
    }

    function exists(bytes32 artifactId) external view returns (bool) {
        return _artifacts[artifactId].status != ArtifactStatus.NONE;
    }
}
