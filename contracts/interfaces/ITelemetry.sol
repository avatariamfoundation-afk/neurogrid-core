// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

interface ITelemetry {
    function kernelEpoch() external view returns (uint256);
}

