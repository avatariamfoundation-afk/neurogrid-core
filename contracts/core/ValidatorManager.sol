// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * ValidatorManager.sol
 * ------------------------------------------------------------------
 * Deterministic validator coordination layer for NeuroGrid.
 *
 * RESPONSIBILITIES
 * - Register / deregister validators
 * - Track validator status and epochs
 * - Provide a canonical validator set for compute + governance
 * - Emit deterministic telemetry into the Kernel
 *
 * IMPORTANT
 * - THIS IS A FULL FILE REPLACEMENT
 * - Replace the entire contents of:
 *
 *   contracts/Core/ValidatorManager.sol
 */

import "./NeuroGridKernel.sol";

contract ValidatorManager {
    /*//////////////////////////////////////////////////////////////
                                TYPES
    //////////////////////////////////////////////////////////////*/

    enum ValidatorStatus {
        NONE,
        ACTIVE,
        SLASHED,
        REMOVED
    }

    struct Validator {
        address validator;
        ValidatorStatus status;
        uint256 joinedEpoch;
        uint256 lastActiveEpoch;
    }

    /*//////////////////////////////////////////////////////////////
                                STORAGE
    //////////////////////////////////////////////////////////////*/

    /// @dev Reference to NeuroGrid kernel
    NeuroGridKernel public immutable kernel;

    /// @dev validator address => Validator struct
    mapping(address => Validator) private _validators;

    /// @dev List of active validator addresses
    address[] private _activeValidators;

    /// @dev Quick lookup for active validator membership
    mapping(address => bool) private _isActive;

    /*//////////////////////////////////////////////////////////////
                                EVENTS
    //////////////////////////////////////////////////////////////*/

    event ValidatorRegistered(
        address indexed validator,
        uint256 epoch
    );

    event ValidatorRemoved(
        address indexed validator,
        uint256 epoch
    );

    event ValidatorSlashed(
        address indexed validator,
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
                        VALIDATOR LIFECYCLE
    //////////////////////////////////////////////////////////////*/

    function registerValidator(address validator) external onlyKernelOwner {
        require(validator != address(0), "INVALID_VALIDATOR");
        require(_validators[validator].status == ValidatorStatus.NONE, "EXISTS");

        uint256 epoch = kernel.currentEpoch();

        _validators[validator] = Validator({
            validator: validator,
            status: ValidatorStatus.ACTIVE,
            joinedEpoch: epoch,
            lastActiveEpoch: epoch
        });

        _activeValidators.push(validator);
        _isActive[validator] = true;

        kernel.emitTelemetry(
            keccak256("VALIDATOR_MANAGER"),
            keccak256("VALIDATOR_REGISTERED"),
            abi.encode(validator)
        );

        emit ValidatorRegistered(validator, epoch);
    }

    function removeValidator(address validator) external onlyKernelOwner {
        Validator storage v = _validators[validator];
        require(v.status == ValidatorStatus.ACTIVE, "NOT_ACTIVE");

        v.status = ValidatorStatus.REMOVED;
        _isActive[validator] = false;

        _removeFromActiveSet(validator);

        uint256 epoch = kernel.currentEpoch();

        kernel.emitTelemetry(
            keccak256("VALIDATOR_MANAGER"),
            keccak256("VALIDATOR_REMOVED"),
            abi.encode(validator)
        );

        emit ValidatorRemoved(validator, epoch);
    }

    function slashValidator(address validator) external onlyKernelOwner {
        Validator storage v = _validators[validator];
        require(v.status == ValidatorStatus.ACTIVE, "NOT_ACTIVE");

        v.status = ValidatorStatus.SLASHED;
        _isActive[validator] = false;

        _removeFromActiveSet(validator);

        uint256 epoch = kernel.currentEpoch();

        kernel.emitTelemetry(
            keccak256("VALIDATOR_MANAGER"),
            keccak256("VALIDATOR_SLASHED"),
            abi.encode(validator)
        );

        emit ValidatorSlashed(validator, epoch);
    }

    function touchValidator(address validator) external onlyKernelOwner {
        Validator storage v = _validators[validator];
        require(v.status == ValidatorStatus.ACTIVE, "NOT_ACTIVE");

        v.lastActiveEpoch = kernel.currentEpoch();
    }

    /*//////////////////////////////////////////////////////////////
                            VIEW FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    function getValidator(address validator) external view returns (Validator memory) {
        return _validators[validator];
    }

    function isActiveValidator(address validator) external view returns (bool) {
        return _isActive[validator];
    }

    function activeValidators() external view returns (address[] memory) {
        return _activeValidators;
    }

    function totalActiveValidators() external view returns (uint256) {
        return _activeValidators.length;
    }

    /*//////////////////////////////////////////////////////////////
                        INTERNAL UTILITIES
    //////////////////////////////////////////////////////////////*/

    function _removeFromActiveSet(address validator) internal {
        uint256 len = _activeValidators.length;
        for (uint256 i = 0; i < len; i++) {
            if (_activeValidators[i] == validator) {
                _activeValidators[i] = _activeValidators[len - 1];
                _activeValidators.pop();
                break;
            }
        }
    }
}
