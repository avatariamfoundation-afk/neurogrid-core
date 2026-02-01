// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title ABSToken
 * @notice Governance / staking token for NeuroGrid
 * @dev OpenZeppelin v5 compatible, non-upgradeable
 */
contract ABSToken is ERC20, Ownable {
    constructor()
        ERC20("ABS Token", "ABS")
        Ownable(msg.sender)
    {
        // Optional initial mint
        // _mint(msg.sender, 1_000_000 ether);
    }
}
