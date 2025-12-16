// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract NeuroGridCore {
    event PostOpMonitoringRequested(
        uint256 indexed caseId,
        address indexed patient
    );

    event MonitoringResultSubmitted(
        uint256 indexed caseId,
        string resultHash
    );

    uint256 public caseCounter;

    function requestPostOpMonitoring() external {
        caseCounter += 1;
        emit PostOpMonitoringRequested(caseCounter, msg.sender);
    }

    function submitMonitoringResult(
        uint256 caseId,
        string calldata resultHash
    ) external {
        emit MonitoringResultSubmitted(caseId, resultHash);
    }
}
