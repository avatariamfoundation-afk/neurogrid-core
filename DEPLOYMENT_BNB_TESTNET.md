# BNB Testnet Deployment Runbook

## Prerequisites
- BNB testnet wallet funded
- Private key stored in .env
- Node.js installed

## Steps
1. Deploy Core:
   npx hardhat run scripts/deploy-core.js --network bnbTestnet

2. Copy Core address into CORE_ADDRESS

3. Deploy Validator:
   npx hardhat run scripts/deploy-validator.js --network bnbTestnet

## Verification
- Confirm contracts on BscScan testnet
- Record addresses in RELEASES.md

## Restrictions
- Testnet only
- No production use

