// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./NeuroGridKernel.sol";

/**
 * @title ValidatorManager
 * @author NeuroGrid
 * @notice Canonical registry for validators verifying compute, artifacts, and research outputs.
 *
 * ROLE
 * ----
 * - Maintains an allowlist of trusted validators
 * - Enforces kernel lifecycle state
 * - Emits verifiable on-chain receipts for validator actions
 *
 * NON-GOALS
 * ---------
 * - No governance voting
 * - No staking or slashing (handled by future modules)
 * - No compute execution
 */

contract ValidatorManager {

    /*//////////////////////////////////////////////////////////////
                                ERRORS
    //////////////////////////////////////////////////////////////*/

    error NotAdmin();
    error KernelInactive();
    error ValidatorExists();
    error ValidatorNotFound();
    error ZeroAddress();

    /*//////////////////////////////////////////////////////////////
                                EVENTS
    //////////////////////////////////////////////////////////////*/

    event ValidatorAdded(
        address indexed validator,
        string metadataURI,
        uint256 timestamp
    );

    event ValidatorRemoved(
        address indexed validator,
        uint256 timestamp
    );

    event ValidatorStatusUpdated(
        address indexed validator,
        bool active,
        uint256 timestamp
    );

    /*//////////////////////////////////////////////////////////////
                                STRUCTS
    //////////////////////////////////////////////////////////////*/

    struct Validator {
        bool active;
        string metadataURI; // off-chain credentials, DID, or proof
        uint256 addedAt;
        bool exists;
    }

    /*//////////////////////////////////////////////////////////////
                            STORAGE VARIABLES
    //////////////////////////////////////////////////////////////*/

    NeuroGridKernel public immutable kernel;
    address public admin;

    mapping(address => Validator) private validators;
    address[] private validatorIndex;

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
                        VALIDATOR MANAGEMENT
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Add a new validator to the registry.
     *
     * @param validator Address of validator
     * @param metadataURI Off-chain identity or credential reference
     */
    function addValidator(
        address validator,
        string calldata metadataURI
    ) external onlyAdmin kernelActive {
        if (validator == address(0)) revert ZeroAddress();
        if (validators[validator].exists) revert ValidatorExists();

        validators[validator] = Validator({
            active: true,
            metadataURI: metadataURI,
            addedAt: block.timestamp,
            exists: true
        });

        validatorIndex.push(validator);

        emit ValidatorAdded(
            validator,
            metadataURI,
            block.timestamp
        );
    }

    /**
     * @notice Disable or re-enable a validator.
     */
    function setValidatorStatus(
        address validator,
        bool active
    ) external onlyAdmin {
        if (!validators[validator].exists) revert ValidatorNotFound();

        validators[validator].active = active;

        emit ValidatorStatusUpdated(
            validator,
            active,
            block.timestamp
        );
    }

    /**
     * @notice Permanently remove a validator.
     */
    function removeValidator(address validator) external onlyAdmin {
        if (!validators[validator].exists) revert ValidatorNotFound();

        delete validators[validator];

        emit ValidatorRemoved(
            validator,
            block.timestamp
        );
    }

    /*//////////////////////////////////////////////////////////////
                        VIEW FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    function isValidator(address validator) external view returns (bool) {
        return validators[validator].exists && validators[validator].active;
    }

    function getValidator(address validator)
        external
        view
        returns (Validator memory)
    {
        if (!validators[validator].exists) revert ValidatorNotFound();
        return validators[validator];
    }

    function getValidatorCount() external view returns (uint256) {
        return validatorIndex.length;
    }

    function getValidatorAt(uint256 index)
        external
        view
        returns (address)
    {
        return validatorIndex[index];
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

