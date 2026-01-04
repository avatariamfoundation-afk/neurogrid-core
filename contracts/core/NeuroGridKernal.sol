// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * @title NeuroGridKernel
 * @author NeuroGrid
 * @notice Core on-chain kernel for NeuroGrid protocol.
 *
 * PURPOSE
 * -------
 * This contract acts as the authoritative on-chain state machine
 * coordinating the NeuroGrid system.
 *
 * It does NOT:
 * - perform AI inference
 * - perform AI training
 * - manage off-chain compute directly
 *
 * It DOES:
 * - define protocol lifecycle
 * - expose global state guards
 * - act as a trust anchor for dependent contracts
 *
 * GOVERNANCE NOTE
 * ---------------
 * Governance logic (DAO, proposals, executors) is intentionally
 * separated and lives under /contracts/governance.
 * This contract only exposes admin hooks.
 */

contract NeuroGridKernel {

    /*//////////////////////////////////////////////////////////////
                                ERRORS
    //////////////////////////////////////////////////////////////*/

    error NotAdmin();
    error InvalidState();
    error ZeroAddress();

    /*//////////////////////////////////////////////////////////////
                                EVENTS
    //////////////////////////////////////////////////////////////*/

    event GridActivated(uint256 timestamp);
    event GridPaused(uint256 timestamp);
    event GridSunset(uint256 timestamp);
    event AdminUpdated(address indexed oldAdmin, address indexed newAdmin);

    /*//////////////////////////////////////////////////////////////
                                ENUMS
    //////////////////////////////////////////////////////////////*/

    enum GridState {
        Init,       // Contract deployed, not yet active
        Active,     // Protocol operational
        Paused,     // Emergency or governance pause
        Sunset      // Protocol permanently disabled
    }

    /*//////////////////////////////////////////////////////////////
                            STORAGE VARIABLES
    //////////////////////////////////////////////////////////////*/

    /// @notice Current lifecycle state of the NeuroGrid protocol
    GridState public gridState;

    /// @notice Administrative authority (temporary until full governance)
    address public admin;

    /// @notice Timestamp of last state transition
    uint256 public lastStateChange;

    /*//////////////////////////////////////////////////////////////
                                MODIFIERS
    //////////////////////////////////////////////////////////////*/

    modifier onlyAdmin() {
        if (msg.sender != admin) revert NotAdmin();
        _;
    }

    modifier onlyActive() {
        if (gridState != GridState.Active) revert InvalidState();
        _;
    }

    modifier notSunset() {
        if (gridState == GridState.Sunset) revert InvalidState();
        _;
    }

    /*//////////////////////////////////////////////////////////////
                                CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/

    constructor(address initialAdmin) {
        if (initialAdmin == address(0)) revert ZeroAddress();

        admin = initialAdmin;
        gridState = GridState.Init;
        lastStateChange = block.timestamp;
    }

    /*//////////////////////////////////////////////////////////////
                        LIFECYCLE MANAGEMENT
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Activate the NeuroGrid protocol.
     * @dev Can only be called once, from Init state.
     */
    function activateGrid() external onlyAdmin {
        if (gridState != GridState.Init) revert InvalidState();

        gridState = GridState.Active;
        lastStateChange = block.timestamp;

        emit GridActivated(block.timestamp);
    }

    /**
     * @notice Pause the protocol.
     * @dev Used for emergency or governance intervention.
     */
    function pauseGrid() external onlyAdmin notSunset {
        if (gridState != GridState.Active) revert InvalidState();

        gridState = GridState.Paused;
        lastStateChange = block.timestamp;

        emit GridPaused(block.timestamp);
    }

    /**
     * @notice Reactivate the protocol from paused state.
     */
    function resumeGrid() external onlyAdmin {
        if (gridState != GridState.Paused) revert InvalidState();

        gridState = GridState.Active;
        lastStateChange = block.timestamp;

        emit GridActivated(block.timestamp);
    }

    /**
     * @notice Permanently disable the protocol.
     * @dev This action is irreversible.
     */
    function sunsetGrid() external onlyAdmin {
        if (gridState == GridState.Sunset) revert InvalidState();

        gridState = GridState.Sunset;
        lastStateChange = block.timestamp;

        emit GridSunset(block.timestamp);
    }

    /*//////////////////////////////////////////////////////////////
                        ADMIN MANAGEMENT
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Transfer administrative control.
     * @dev Governance contracts may call this in the future.
     */
    function updateAdmin(address newAdmin) external onlyAdmin {
        if (newAdmin == address(0)) revert ZeroAddress();

        address oldAdmin = admin;
        admin = newAdmin;

        emit AdminUpdated(oldAdmin, newAdmin);
    }

    /*//////////////////////////////////////////////////////////////
                        VIEW HELPERS
    //////////////////////////////////////////////////////////////*/

    function isActive() external view returns (bool) {
        return gridState == GridState.Active;
    }

    function isPaused() external view returns (bool) {
        return gridState == GridState.Paused;
    }

    function isSunset() external view returns (bool) {
        return gridState == GridState.Sunset;
    }

    /*//////////////////////////////////////////////////////////////
                        STORAGE GAP (UPGRADE SAFETY)
    //////////////////////////////////////////////////////////////*/

    uint256[50] private __gap;
}
