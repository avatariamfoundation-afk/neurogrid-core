// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title MedToken
 * @notice Utility token for NeuroGrid / MedIntel ecosystem
 * @dev Non-upgradeable ERC20 using OpenZeppelin v5 Ownable pattern
 */
contract MedToken is ERC20, Ownable {
    constructor()
        ERC20("MedToken", "MED")
        Ownable(msg.sender)
    {
        // Initial supply can be minted here if required
        // _mint(msg.sender, 1_000_000 ether);
    }
}
