struct ComputeNode {
    address operator;
    uint256 stake;
    uint256 reputation;
    bool active;
}

Mandatory functions:
registerNode()
deactivateNode()
getNode(address)

Rules:
stake > 0 required
emit events
fail loudly

event NodeRegistered(address indexed operator);
event NodeDeactivated(address indexed operator);
