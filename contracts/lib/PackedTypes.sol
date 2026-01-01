pragma solidity ^0.8.21;

library PackedTypes {
    struct ResultMeta {
        uint64 modelId;
        uint64 version;
        uint64 epoch;
        uint64 flags;
    }
}

