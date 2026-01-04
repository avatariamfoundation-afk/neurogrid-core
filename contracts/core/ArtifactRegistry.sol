// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./NeuroGridKernel.sol";

/**
 * @title ArtifactRegistry
 * @author NeuroGrid
 * @notice Immutable registry for research artifacts, AI outputs, and proofs.
 *
 * ROLE
 * ----
 * - Registers artifacts produced by compute providers or researchers
 * - Enforces kernel lifecycle state
 * - Emits canonical on-chain receipts for verification
 *
 * NON-GOALS
 * ---------
 * - No storage of raw data
 * - No execution of compute
 * - No governance logic
 */

contract ArtifactRegistry {

    /*//////////////////////////////////////////////////////////////
                                ERRORS
    //////////////////////////////////////////////////////////////*/

    error NotAdmin();
    error KernelInactive();
    error ArtifactExists();
    error ArtifactNotFound();
    error ZeroAddress();

    /*//////////////////////////////////////////////////////////////
                                EVENTS
    //////////////////////////////////////////////////////////////*/

    event ArtifactRegistered(
        bytes32 indexed artifactId,
        address indexed submitter,
        string uri,
        bytes32 contentHash,
        uint256 timestamp
    );

    event ArtifactStatusUpdated(
        bytes32 indexed artifactId,
        uint8 status,
        uint256 timestamp
    );

    /*//////////////////////////////////////////////////////////////
                                STRUCTS
    //////////////////////////////////////////////////////////////*/

    struct Artifact {
        address submitter;
        string uri;          // IPFS / Arweave / HTTPS
        bytes32 contentHash; // Hash of artifact contents
        uint8 status;        // 0 = submitted, 1 = verified, 2 = deprecated
        uint256 timestamp;
        bool exists;
    }

    /*//////////////////////////////////////////////////////////////
                            STORAGE VARIABLES
    //////////////////////////////////////////////////////////////*/

    NeuroGridKernel public immutable kernel;
    address public admin;

    mapping(bytes32 => Artifact) private artifacts;
    uint256 public artifactCount;

    /*//////////////////////////////////////////////////////////////
                                MODIFIERS
    //////////////////////////////////////////////////////////////*/

    modifier onlyAdmin() {
        if (msg.sender != admin) revert NotAdmin();
        _;
    }

    modifier kernelActive() {
        if (!kernel.isActive()) revert KernelInactive();
        _;
    }

    /*//////////////////////////////////////////////////////////////
                                CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/

    constructor(address kernelAddress) {
        if (kernelAddress == address(0)) revert ZeroAddress();
        kernel = NeuroGridKernel(kernelAddress);
        admin = kernel.admin();
    }

    /*//////////////////////////////////////////////////////////////
                        ARTIFACT REGISTRATION
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Register a new research artifact.
     *
     * @param artifactId Deterministic ID (hash of job / dataset / model)
     * @param uri Off-chain location of artifact
     * @param contentHash Hash of artifact payload
     */
    function registerArtifact(
        bytes32 artifactId,
        string calldata uri,
        bytes32 contentHash
    ) external kernelActive {
        if (artifacts[artifactId].exists) revert ArtifactExists();

        artifacts[artifactId] = Artifact({
            submitter: msg.sender,
            uri: uri,
            contentHash: contentHash,
            status: 0,
            timestamp: block.timestamp,
            exists: true
        });

        artifactCount += 1;

        emit ArtifactRegistered(
            artifactId,
            msg.sender,
            uri,
            contentHash,
            block.timestamp
        );
    }

    /*//////////////////////////////////////////////////////////////
                        ARTIFACT STATUS
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Update artifact lifecycle status.
     * @dev Admin-only (governance / review layer)
     *
     * status meanings:
     * 0 = submitted
     * 1 = verified
     * 2 = deprecated
     */
    function updateArtifactStatus(
        bytes32 artifactId,
        uint8 status
    ) external onlyAdmin {
        if (!artifacts[artifactId].exists) revert ArtifactNotFound();

        artifacts[artifactId].status = status;

        emit ArtifactStatusUpdated(
            artifactId,
            status,
            block.timestamp
        );
    }

    /*//////////////////////////////////////////////////////////////
                        VIEW FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    function getArtifact(bytes32 artifactId)
        external
        view
        returns (Artifact memory)
    {
        if (!artifacts[artifactId].exists) revert ArtifactNotFound();
        return artifacts[artifactId];
    }

    /*//////////////////////////////////////////////////////////////
                        ADMIN SYNC
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Sync admin with Kernel admin.
     */
    function syncAdmin() external {
        admin = kernel.admin();
    }

    /*//////////////////////////////////////////////////////////////
                        STORAGE GAP
    //////////////////////////////////////////////////////////////*/

    uint256[50] private __gap;
}
