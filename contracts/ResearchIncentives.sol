// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ResearchIncentives {
    address public owner;

    struct Insight {
        address contributor;
        string description;
        uint256 reward;
        bool validated;
    }

    mapping(uint256 => Insight) public insights;
    uint256 public insightCount;

    event InsightSubmitted(
        uint256 indexed insightId,
        address indexed contributor,
        uint256 reward
    );

    event InsightValidated(
        uint256 indexed insightId,
        address indexed validator
    );

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function submitInsight(
        string calldata description,
        uint256 reward
    ) external onlyOwner {
        insights[insightCount] = Insight(
            msg.sender,
            description,
            reward,
            false
        );

        emit InsightSubmitted(insightCount, msg.sender, reward);
        insightCount++;
    }

    function validateInsight(uint256 insightId) external onlyOwner {
        Insight storage insight = insights[insightId];
        require(!insight.validated, "Already validated");

        insight.validated = true;
        emit InsightValidated(insightId, msg.sender);
    }
}

