// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract ComputeGateway {
    address public immutable authorizedSigner;
    uint256 public constant MAX_DRIFT = 300; // 5 minutes

    error InvalidSignature();
    error StalePayload();

    constructor(address signer) {
        authorizedSigner = signer;
    }

    function submit(
        bytes32 jobId,
        bytes32 resultHash,
        uint256 timestamp,
        bytes calldata signature
    ) external {
        if (block.timestamp > timestamp + MAX_DRIFT) revert StalePayload();

        bytes32 digest = keccak256(
            abi.encodePacked(jobId, resultHash, timestamp, address(this))
        );

        if (!_verify(digest, signature)) revert InvalidSignature();

        _commit(jobId, resultHash);
    }

    function _commit(bytes32 jobId, bytes32 resultHash) internal {
        // minimal state write only
    }

    function _verify(bytes32 digest, bytes calldata sig) internal view returns (bool) {
        (bytes32 r, bytes32 s, uint8 v) = _split(sig);
        address recovered = ecrecover(
            keccak256(
                abi.encodePacked("\x19Ethereum Signed Message:\n32", digest)
            ),
            v, r, s
        );
        return recovered == authorizedSigner;
    }

    function _split(bytes calldata sig)
        internal
        pure
        returns (bytes32 r, bytes32 s, uint8 v)
    {
        assembly {
            r := calldataload(sig.offset)
            s := calldataload(add(sig.offset, 32))
            v := byte(0, calldataload(add(sig.offset, 64)))
        }
    }
}

