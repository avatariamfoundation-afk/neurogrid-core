// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/*
 * NeuroGrid UUPS Upgrade Base
 * --------------------------
 * - Explicit upgrade authority
 * - No hidden upgrade paths
 * - Deterministic governance-controlled upgrades only
 *
 * NOTE:
 * - This contract is intended to be INHERITED by upgradeable core modules.
 * - Initialization MUST be used instead of constructors.
 */

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

abstract contract UUPSUpgradeBase is
    Initializable,
    UUPSUpgradeable,
    OwnableUpgradeable
{
    /// @dev Emitted whenever an implementation upgrade is authorized
    event UpgradeAuthorized(
        address indexed executor,
        address indexed newImplementation,
        uint256 timestamp
    );

    /**
     * @notice Core initializer
     * @dev Must be called by inheriting contract initializer
     */
    function __UUPSUpgradeBase_init(address initialOwner) internal onlyInitializing {
        __Ownable_init();
        __UUPSUpgradeable_init();

        _transferOwnership(initialOwner);
    }

    /**
     * @dev UUPS authorization hook
     * - ONLY owner (governance / executor) may upgrade
     * - Emits immutable audit event
     */
    function _authorizeUpgrade(address newImplementation)
        internal
        override
        onlyOwner
    {
        emit UpgradeAuthorized(
            msg.sender,
            newImplementation,
            block.timestamp
        );
    }

    /**
     * @notice Explicit upgrade interface (optional use)
     * @dev Makes upgrade intent visible in ABI
     */
    function upgradeToNewImplementation(address newImplementation) external onlyOwner {
        _upgradeTo(newImplementation);
    }

    /**
     * @notice Safety check: confirms UUPS compatibility
     */
    function proxiableUUID()
        public
        view
        override
        returns (bytes32)
    {
        return keccak256("neurogrid.uups.upgrade.base");
    }
}

