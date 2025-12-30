// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title NeuroGridCore
 * @notice Immutable registry-only core for DeSci artifacts.
 *         Contains NO governance, incentives, or access control.
 */
contract NeuroGridCore {

    enum ArtifactStatus {
        Draft,
        Submitted,
        Validated,
        Retracted,
        Superseded
    }

    struct Artifact {
        bytes32 artifactId;
        bytes32 contentHash;
        address author;
        uint256 timestamp;
        ArtifactStatus status;
    }

    mapping(bytes32 => Artifact) public artifacts;

    event ArtifactRegistered(
        bytes32 indexed artifactId,
        bytes32 indexed contentHash,
        address indexed author
    );

    event ArtifactStatusUpdated(
        bytes32 indexed artifactId,
        ArtifactStatus status
    );

    /**
     * @notice Register a scientific artifact by immutable hash
     */
    function registerArtifact(
        bytes32 artifactId,
        bytes32 contentHash
    ) external {
        require(artifacts[artifactId].timestamp == 0, "Artifact exists");

        artifacts[artifactId] = Artifact({
            artifactId: artifactId,
            contentHash: contentHash,
            author: msg.sender,
            timestamp: block.timestamp,
            status: ArtifactStatus.Submitted
        });

        emit ArtifactRegistered(artifactId, contentHash, msg.sender);
    }

    /**
     * @notice Update lifecycle state (authorization handled externally)
     */
    function updateArtifactStatus(
        bytes32 artifactId,
        ArtifactStatus newStatus
    ) external {
        Artifact storage artifact = artifacts[artifactId];
        require(artifact.timestamp != 0, "Artifact not found");

        artifact.status = newStatus;
        emit ArtifactStatusUpdated(artifactId, newStatus);
    }
}
