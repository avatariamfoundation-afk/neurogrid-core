// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./MedToken.sol";

contract NeuroGridCore {
    MedToken public medToken;
    address public owner;

    event Initialized(address indexed medTokenAddress, address indexed owner);

    constructor(address _medToken) {
        require(_medToken != address(0), "Invalid MedToken address");
        medToken = MedToken(_medToken);
        owner = msg.sender;

        emit Initialized(_medToken, owner);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    function getMedToken() external view returns (address) {
        return address(medToken);
    }
}
