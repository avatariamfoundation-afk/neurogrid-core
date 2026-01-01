// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * @title IValidatorModule
 * @notice Enforced submission boundary for validations
 */
interface IValidatorModule {
    function submitValidation(
        bytes32 artifactHash,
        string calldata artifactDomain,
        string calldata validationType,
        bytes32 validatorSignature,
        bool emergencyFlag
    ) external;
}

