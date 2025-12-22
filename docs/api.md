// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/access/Ownable.sol";

contract NeuroGrid is Ownable {
    struct ComputeTask {
        string description;
        address requester;
        uint256 reward;
        bool completed;
    }

    mapping(uint256 => ComputeTask) public tasks;
    uint256 public taskCount;
    address public neuroToken;

    constructor(address _neuroToken) {
        neuroToken = _neuroToken;
    }

    function submitTask(string memory _description, uint256 _reward) public {
        tasks[taskCount] = ComputeTask(_description, msg.sender, _reward, false);
        taskCount++;
    }

    function completeTask(uint256 _taskId) public {
        require(_taskId < taskCount, "Task does not exist");
        require(!tasks[_taskId].completed, "Task already completed");
        tasks[_taskId].completed = true;
        // Placeholder for reward mechanism
    }

    function getTask(uint256 _taskId) public view returns (string memory, address, uint256, bool) {
        ComputeTask memory task = tasks[_taskId];
        return (task.description, task.requester, task.reward, task.completed);
    }
}
