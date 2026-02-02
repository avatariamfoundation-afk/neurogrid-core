// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/AccessControl.sol";

contract RegistryAuthorityModule is AccessControl {
    bytes32 public constant REGISTRY_WRITER_ROLE =
        keccak256("REGISTRY_WRITER_ROLE");

    struct RegistryEntry {
        address subject;
        uint256 timestamp;
        bytes32 dataHash;
    }

    mapping(bytes32 => RegistryEntry) private registry;

    event RegistryWritten(
        bytes32 indexed key,
        address indexed subject,
        bytes32 dataHash,
        uint256 timestamp
    );

    constructor(address admin) {
        _grantRole(DEFAULT_ADMIN_ROLE, admin);
        _grantRole(REGISTRY_WRITER_ROLE, admin);
    }

    function writeRegistry(
        bytes32 key,
        address subject,
        bytes32 dataHash
    ) external onlyRole(REGISTRY_WRITER_ROLE) {
        registry[key] = RegistryEntry(
            subject,
            block.timestamp,
            dataHash
        );

        emit RegistryWritten(
            key,
            subject,
            dataHash,
            block.timestamp
        );
    }

    function readRegistry(bytes32 key)
        external
        view
        returns (RegistryEntry memory)
    {
        return registry[key];
    }
}

