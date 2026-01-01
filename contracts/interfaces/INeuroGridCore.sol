// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * @title INeuroGridCore
 * @notice Read-only + anchoring interface boundary
 * @dev No write access beyond anchoring through approved modules
 */
interface INeuroGridCore {
    function registry(uint256 id)
        external
        view
        returns (
            bytes32 recordHash,
            string memory domain,
            string memory recordType,
            uint256 timestamp,
            address submittedBy,
            bool emergencyFlag
        );

    function crossLinks(uint256 id)
        external
        view
        returns (
            bytes32 sourceHash,
            string memory sourceDomain,
            bytes32 targetHash,
            string memory targetDomain,
            string memory linkType,
            uint256 timestamp,
            address submittedBy,
            bool emergencyFlag
        );

    function emergencyActive() external view returns (bool);

    function anchorRegistryRecord(
        bytes32 recordHash,
        string calldata domain,
        string calldata recordType,
        bool emergencyFlag
    ) external;
}

