// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * ABSToken.sol
 * ------------------------------------------------------------------
 * Native utility + governance token for NeuroGrid (ABST)
 *
 * RESPONSIBILITIES
 * - Incentives for validators, compute nodes, researchers
 * - Governance voting power (NeuroDAO)
 * - Deterministic emission + burn telemetry
 *
 * IMPORTANT
 * - THIS IS A FULL FILE REPLACEMENT
 * - Replace the entire contents of:
 *
 *   contracts/Core/ABSToken.sol
 */

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ABSToken is ERC20, Ownable {
    /*//////////////////////////////////////////////////////////////
                                CONSTANTS
    //////////////////////////////////////////////////////////////*/

    uint256 public constant MAX_SUPPLY = 1_000_000_000 ether;

    /*//////////////////////////////////////////////////////////////
                                EVENTS
    //////////////////////////////////////////////////////////////*/

    event TokensMinted(address indexed to, uint256 amount);
    event TokensBurned(address indexed from, uint256 amount);

    /*//////////////////////////////////////////////////////////////
                              CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/

    constructor(address initialOwner)
        ERC20("Aethera BioSync Token", "ABST")
    {
        require(initialOwner != address(0), "INVALID_OWNER");
        _transferOwnership(initialOwner);
    }

    /*//////////////////////////////////////////////////////////////
                           MINT / BURN LOGIC
    //////////////////////////////////////////////////////////////*/

    function mint(address to, uint256 amount) external onlyOwner {
        require(to != address(0), "INVALID_TO");
        require(totalSupply() + amount <= MAX_SUPPLY, "MAX_SUPPLY_EXCEEDED");

        _mint(to, amount);
        emit TokensMinted(to, amount);
    }

    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
        emit TokensBurned(msg.sender, amount);
    }

    /*//////////////////////////////////////////////////////////////
                           VIEW HELPERS
    //////////////////////////////////////////////////////////////*/

    function remainingSupply() external view returns (uint256) {
        return MAX_SUPPLY - totalSupply();
    }
}
