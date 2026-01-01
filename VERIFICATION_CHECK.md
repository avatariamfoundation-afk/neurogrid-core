# CORE VERIFICATION CHECK

## Contract Integrity
- [ ] ComputeGateway deployed with immutable signer
- [ ] Signature domain binds contract address
- [ ] Timestamp drift enforced (MAX_DRIFT)
- [ ] Optimizer enabled (runs=200, viaIR=true)

## Gas Controls
- [ ] No dynamic arrays in storage
- [ ] Minimal state writes only
- [ ] Packed structs used where applicable
- [ ] Gas report generated and archived

## Security
- [ ] No external calls in submit()
- [ ] Revert on stale or invalid payloads
- [ ] No randomness, no ML, no HTTP on-chain

## Build & CI
- [ ] Hardhat compile passes
- [ ] Tests pass
- [ ] Gas reporter attached to CI artifact

