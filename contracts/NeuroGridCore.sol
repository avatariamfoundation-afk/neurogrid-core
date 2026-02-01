// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Pausable.sol";

/**
 * @title NeuroGridCore
 * @notice Core control contract for NeuroGrid protocol
 * @dev OpenZeppelin v5 compatible (non-upgradeable)
 */
contract NeuroGridCore is Ownable, Pausable {
    /*//////////////////////////////////////////////////////////////
                                EVENTS
    //////////////////////////////////////////////////////////////*/

    event SystemPaused(address indexed caller);
    event SystemUnpaused(address indexed caller);

    /*//////////////////////////////////////////////////////////////
                              CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/

    constructor(address initialOwner) Ownable(initialOwner) {}

    /*//////////////////////////////////////////////////////////////
                              ADMIN
    //////////////////////////////////////////////////////////////*/

    function pause() external onlyOwner {
        _pause();
        emit SystemPaused(msg.sender);
    }

    function unpause() external onlyOwner {
        _unpause();
        emit SystemUnpaused(msg.sender);
    }
}
