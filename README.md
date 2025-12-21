# NeuroGrid Core

NeuroGrid Core is the blockchain and identity backbone for NeuroGrid — the global AI × DeSci system for post-operative care and remote patient monitoring (RPM). This repo contains core smart-contract interfaces, governance outlines, and protocol docs for consent, device registration, and verifiable scientific provenance.

Key focus:
- Consent & data-access contracts
- Device registration and identity
- Reputation & funding primitives for DeSci
- Minimal on-chain footprint (hash + metadata only)

  ---
  
# NeuroGrid-Core: AI-Driven Decentralized Grid on BNB Chain

NeuroGrid is a Web3 platform for decentralized AI-powered grids, enabling secure, neural-network-inspired data sharing and computation. Built for the BNB Chain hackathon, it lays the foundation for scalable AI services in my company.

## Features
- Smart contracts for grid node registration and data flow.
- Basic AI integration via off-chain APIs for predictive analytics.
- P2P networking for node connections (expandable).

## Quick Start
1. Clone the repo: `git clone https://github.com/avatariamfoundation-afk/neurogrid-core.git`
2. Install dependencies: `npm install`
3. Set up environment: Copy `.env.example` to `.env` and fill in keys.
4. Deploy to BNB Testnet: `npx hardhat run scripts/deploy.js --network testnet`
5. Run demo: Open `index.html` in browser for a basic grid visualization.

## Demo
Watch the [demo video](link-to-video) showing node registration and AI predictions.

## Future Roadmap
- Cross-chain expansion for broader AI grids.
- Enhanced security with ZKPs.

For issues, open a GitHub issue.
