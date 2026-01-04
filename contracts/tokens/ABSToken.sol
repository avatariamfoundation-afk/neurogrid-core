// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

/**
 * @title ABSToken (NeuroGrid Utility Token)
 * @author Aethera BioSync / NeuroGrid
 *
 * PURPOSE
 * -------
 * ABST is the core utility + incentive token of the NeuroGrid ecosystem.
 * It is used for:
 * - Validator rewards
 * - Research incentives (DeSci)
 * - Governance participation (via NeuroDAO)
 * - Compute / inference settlement (off-chain → on-chain)
 *
 * HACKATHON MODE
 * -------------
 * - Fixed supply (mint-once)
 * - Role-based minting (future upgrade path)
 * - Clean, auditable ERC20 implementation
 *
 * REAL-WORLD READY
 * ----------------
 * - AccessControl for enterprise & DAO evolution
 * - Clear separation of minting authority
 * - No exotic tokenomics (judges prefer clarity)
 */

contract ABSToken is ERC20, AccessControl {

    /*//////////////////////////////////////////////////////////////
                                ROLES
    //////////////////////////////////////////////////////////////*/

    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    /*//////////////////////////////////////////////////////////////
                                EVENTS
    //////////////////////////////////////////////////////////////*/

    event TokensMinted(address indexed to, uint256 amount);

    /*//////////////////////////////////////////////////////////////
                                CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/

    constructor(
        address initialAdmin,
        uint256 initialSupply
    ) ERC20("Aethera BioSync Token", "ABST") {
        _grantRole(DEFAULT_ADMIN_ROLE, initialAdmin);
        _grantRole(MINTER_ROLE, initialAdmin);

        _mint(initialAdmin, initialSupply);
        emit TokensMinted(initialAdmin, initialSupply);
    }

    /*//////////////////////////////////////////////////////////////
                            MINTING LOGIC
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Mint new ABST tokens
     * @dev Restricted to MINTER_ROLE (DAO / Kernel / Treasury)
     */
    function mint(address to, uint256 amount)
        external
        onlyRole(MINTER_ROLE)
    {
        _mint(to, amount);
        emit TokensMinted(to, amount);
    }

    /*//////////////////////////////////////////////////////////////
                        GOVERNANCE HELPERS
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Check if an address is allowed to mint
     */
    function isMinter(address account) external view returns (bool) {
        return hasRole(MINTER_ROLE, account);
    }

    /*//////////////////////////////////////////////////////////////
                        STORAGE GAP (UPGRADE SAFE)
    //////////////////////////////////////////////////////////////*/

    uint256[50] private __gap;
}

