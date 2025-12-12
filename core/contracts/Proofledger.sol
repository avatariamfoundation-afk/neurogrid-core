// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract ProofLedger {
    struct Proof {
        bytes32 resultHash;
        address agent;
        string metadataURI;
        bool compliance;
        uint256 ts;
    }

    mapping(bytes32 => Proof) public proofs;

    event ProofRegistered(bytes32 indexed resultHash, address indexed agent, string metadataURI, bool compliance, uint256 ts);

    function registerProof(bytes32 _resultHash, string calldata _metadataURI, bool _compliance) external {
        require(_resultHash != bytes32(0), "zero hash");
        require(proofs[_resultHash].ts == 0, "exists");
        proofs[_resultHash] = Proof({ resultHash: _resultHash, agent: msg.sender, metadataURI: _metadataURI, compliance: _compliance, ts: block.timestamp });
        emit ProofRegistered(_resultHash, msg.sender, _metadataURI, _compliance, block.timestamp);
    }

    function getProof(bytes32 _resultHash) external view returns (Proof memory) {
        return proofs[_resultHash];
    }
}
