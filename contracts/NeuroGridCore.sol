// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";

/**
 * @title NeuroGridCore
 * @notice Immutable registry for DeSci artifacts with access-controlled status updates, transition rules, and security enhancements.
 * @dev Off-chain artifactId generation: Use keccak256(abi.encode(contentHash, author, timestamp)) for verification.
 */
contract NeuroGridCore is Ownable, Pausable {
    enum ArtifactStatus {
        Draft,
        Submitted,
        Validated,
        Retracted,
        Superseded
    }

    bytes32 constant NO_SUPERSESSION = bytes32(0);  // Constant for readability: indicates no supersession

    struct Artifact {
        bytes32 artifactId;
        bytes contentHash;  // Use `bytes` to support variable-length hashes (e.g., IPFS CID)
        bytes32 supersededBy;  // NO_SUPERSESSION indicates no supersession
        address author;
        uint256 timestamp;
        ArtifactStatus status;
    }

    mapping(bytes32 => Artifact) public artifacts;
    uint256 private nonce;  // Used for artifactId generation to avoid timestamp manipulation

    // Events
    event ArtifactRegistered(
        bytes32 indexed artifactId,
        bytes contentHash,  // Emitted for off-chain indexing
        address indexed author,
        uint256 timestamp
    );

    event ArtifactStatusUpdated(
        bytes32 indexed artifactId,
        ArtifactStatus newStatus,
        address indexed updater
    );

    event ArtifactSuperseded(
        bytes32 indexed oldArtifactId,
        bytes32 indexed newArtifactId,
        address indexed updater,
        uint256 timestamp
    );

    event Paused(address indexed account, string reason);
    event Unpaused(address indexed account);

    /**
     * @notice Register a scientific artifact with a deterministically generated unique ID and content hash.
     * @dev Generates artifactId using abi.encode and nonce to prevent front-running and ensure uniqueness. Reverts if inputs are invalid or artifact exists.
     * @param contentHash Cryptographic hash or IPFS CID of the content.
     */
    function registerArtifact(bytes calldata contentHash) external whenNotPaused {
        require(contentHash.length > 0, "Invalid contentHash");

        // Generate unique artifactId deterministically (using nonce for unpredictability)
        bytes32 artifactId = keccak256(abi.encode(contentHash, msg.sender, nonce++));
        require(artifacts[artifactId].timestamp == 0, "Artifact exists");

        artifacts[artifactId] = Artifact({
            artifactId: artifactId,
            contentHash: contentHash,
            supersededBy: NO_SUPERSESSION,  // No supersession initially
            author: msg.sender,
            timestamp: block.timestamp,
            status: ArtifactStatus.Submitted  // Default status
        });

        emit ArtifactRegistered(artifactId, contentHash, msg.sender, block.timestamp);
    }

    /**
     * @notice Update the status of an artifact with access control and transition rules.
     * @dev Only callable by the contract owner. Enforces valid status transitions and validates artifact existence.
     * @param artifactId ID of the artifact to update.
     * @param newStatus New status to assign.
     */
    function updateArtifactStatus(
        bytes32 artifactId,
        ArtifactStatus newStatus
    ) external onlyOwner whenNotPaused {
        Artifact storage artifact = artifacts[artifactId];
        require(artifact.timestamp != 0, "Artifact not found");  // Validates artifactId exists
        require(_isValidTransition(artifact.status, newStatus), "Invalid status transition");

        artifact.status = newStatus;
        emit ArtifactStatusUpdated(artifactId, newStatus, msg.sender);
    }

    /**
     * @notice Supersede an artifact by linking it to a new one.
     * @dev Only callable by the contract owner. Sets status to Superseded and links to new artifact.
     * @param oldArtifactId ID of the artifact to supersede.
     * @param newArtifactId ID of the new artifact.
     */
    function supersedeArtifact(
        bytes32 oldArtifactId,
        bytes32 newArtifactId
    ) external onlyOwner whenNotPaused {
        require(artifacts[oldArtifactId].timestamp != 0, "Old artifact not found");
        require(artifacts[newArtifactId].timestamp != 0, "New artifact not found");
        require(artifacts[oldArtifactId].status == ArtifactStatus.Validated, "Old artifact must be Validated");

        artifacts[oldArtifactId].status = ArtifactStatus.Superseded;
        artifacts[oldArtifactId].supersededBy = newArtifactId;

        emit ArtifactSuperseded(oldArtifactId, newArtifactId, msg.sender, block.timestamp);
    }

    /**
     * @notice Pause all contract functions in case of emergency.
     * @dev Only callable by the contract owner. Emits reason for transparency.
     * @param reason Reason for pausing.
     */
    function pause(string memory reason) external onlyOwner {
        _pause();
        emit Paused(msg.sender, reason);
    }

    /**
     * @notice Unpause all contract functions.
     * @dev Only callable by the contract owner.
     */
    function unpause() external onlyOwner {
        _unpause();
        emit Unpaused(msg.sender);
    }

    /**
     * @dev Validates allowed status transitions (e.g., Draft → Submitted → Validated, including Superseded retraction).
     */
    function _isValidTransition(
        ArtifactStatus currentStatus,
        ArtifactStatus newStatus
    ) internal pure returns (bool) {
        return
            (currentStatus == ArtifactStatus.Draft && newStatus == ArtifactStatus.Submitted) ||
            (currentStatus == ArtifactStatus.Submitted && newStatus == ArtifactStatus.Validated) ||
            (currentStatus == ArtifactStatus.Validated && newStatus == ArtifactStatus.Retracted) ||
            (currentStatus == ArtifactStatus.Validated && newStatus == ArtifactStatus.Superseded) ||
            (currentStatus == ArtifactStatus.Superseded && newStatus == ArtifactStatus.Retracted);  // Allow retraction of superseded
    }

    /// @notice Prevents accidental ETH transfers from reverting.
    receive() external payable {}
}
