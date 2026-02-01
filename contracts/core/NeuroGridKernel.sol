// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * NeuroGridKernel.sol
 * ------------------------------------------------------------------
 * Core deterministic kernel for the NeuroGrid system.
 *
 * RESPONSIBILITIES
 * - Global epoch clock (deterministic time anchor)
 * - System-wide event emission (single source of truth)
 * - Telemetry root for all downstream registries
 * - UUPS-safe upgrade foundation
 *
 * IMPORTANT
 * - This file is a FULL REPLACEMENT
 * - Paste over the existing NeuroGridKernel.sol entirely
 * - Storage layout is locked and explicitly ordered
 *
 * GOVERNANCE
 * - Upgrade authority delegated externally (NeuroDAO / Executor)
 * - Kernel itself contains NO governance logic
 */

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";


contract NeuroGridKernel is Initializable, UUPSUpgradeable, OwnableUpgradeable {
    /*//////////////////////////////////////////////////////////////
                                STORAGE
    //////////////////////////////////////////////////////////////*/

    /// @dev Global deterministic epoch counter
    uint256 private _epoch;

    /// @dev Hash of the previous epoch (for deterministic chaining)
    bytes32 private _lastEpochHash;

    /// @dev System paused flag (kernel-level safety)
    bool private _paused;

    /// @dev Reserved storage gap for future upgrades
    uint256[46] private __gap;

    /*//////////////////////////////////////////////////////////////
                                EVENTS
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Emitted every time the system advances one epoch
     * @param epoch New epoch number
     * @param epochHash Deterministic hash of this epoch
     * @param triggeredBy Caller responsible for advancement
     */
    event EpochAdvanced(
        uint256 indexed epoch,
        bytes32 indexed epochHash,
        address indexed triggeredBy
    );

    /**
     * @notice Emitted for all kernel-level telemetry
     * @param epoch Current epoch
     * @param subject Logical subject (contract / module)
     * @param action Action identifier
     * @param actor Caller responsible
     * @param data Arbitrary deterministic payload
     */
    event Telemetry(
        uint256 indexed epoch,
        bytes32 indexed subject,
        bytes32 indexed action,
        address actor,
        bytes data
    );

    /**
     * @notice Kernel pause state changed
     * @param paused New pause state
     */
    event KernelPauseSet(bool paused);

    /*//////////////////////////////////////////////////////////////
                                INITIALIZER
    //////////////////////////////////////////////////////////////*/

    function initialize(address initialOwner) external initializer {
        __Ownable_init(msg.sender);
        __UUPSUpgradeable_init();

        _transferOwnership(initialOwner);

        _epoch = 0;
        _lastEpochHash = bytes32(0);
        _paused = false;
    }

    /*//////////////////////////////////////////////////////////////
                            EPOCH LOGIC
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Advance the global deterministic epoch
     * @dev Epoch hash is deterministic and chain-linked
     */
    function advanceEpoch() external returns (uint256 newEpoch) {
        require(!_paused, "KERNEL_PAUSED");

        uint256 nextEpoch = _epoch + 1;

        bytes32 epochHash = keccak256(
            abi.encodePacked(
                block.chainid,
                address(this),
                nextEpoch,
                _lastEpochHash
            )
        );

        _epoch = nextEpoch;
        _lastEpochHash = epochHash;

        emit EpochAdvanced(nextEpoch, epochHash, msg.sender);

        return nextEpoch;
    }

    /*//////////////////////////////////////////////////////////////
                            TELEMETRY
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Emit a deterministic telemetry event
     * @dev Used by all downstream contracts
     */
    function emitTelemetry(
        bytes32 subject,
        bytes32 action,
        bytes calldata data
    ) external {
        emit Telemetry(
            _epoch,
            subject,
            action,
            msg.sender,
            data
        );
    }

    /*//////////////////////////////////////////////////////////////
                            VIEW FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    function currentEpoch() external view returns (uint256) {
        return _epoch;
    }

    function lastEpochHash() external view returns (bytes32) {
        return _lastEpochHash;
    }

    function paused() external view returns (bool) {
        return _paused;
    }

    /*//////////////////////////////////////////////////////////////
                            SAFETY CONTROLS
    //////////////////////////////////////////////////////////////*/

    function setPaused(bool pauseState) external onlyOwner {
        _paused = pauseState;
        emit KernelPauseSet(pauseState);
    }

    /*//////////////////////////////////////////////////////////////
                        UUPS AUTHORIZATION
    //////////////////////////////////////////////////////////////*/

    function _authorizeUpgrade(address newImplementation)
        internal
        override
        onlyOwner
    {}

}
