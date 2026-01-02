# NeuroGrid — Decentralized AI & DeSci Infrastructure on BNB Chain  
**Built by Aethera BioSync**  
**BNB Hackathon Submission — Smart Builders Challenge**

NeuroGrid is an open-source decentralized intelligence platform built on **BNB Chain**, combining **AI-driven biosignal analysis**, **DeSci collaboration**, and **Web3 smart contracts** for secure research validation and incentive alignment.

The system is designed to demonstrate **real-world scientific infrastructure** while remaining **hackathon-ready**, modular, and extensible toward production deployment.

---

## What NeuroGrid Does (In One Sentence)

NeuroGrid enables **AI-generated research outputs** to be **verifiably recorded on-chain**, collaboratively reviewed through **DeSci workflows**, and **rewarded via smart contracts** on BNB Chain.

---

## Core Pillars

### 🧠 AI (MedIntel)
- Processes biosignal or synthetic biomedical data
- Generates deterministic analysis outputs
- Designed for ethical, explainable inference pipelines
- Outputs are structured for on-chain anchoring

### 🔗 Blockchain (NeuroGrid-Core)
- Immutable artifact registry
- ERC20-based incentive mechanism
- Research contribution tracking
- Access-controlled state transitions
- Deployed and tested via Hardhat (BNB-compatible)

### 🧪 DeSci (Collaboration Layer)
- Open research sharing
- Contribution validation
- Incentive alignment
- Transparent auditability

---

## System Flow (End-to-End)

[User / Research Input]
↓
[MedIntel — AI Analysis]
↓
[Oracle / Bridge Layer]
↓
[NeuroGrid-Core — On-Chain Storage + Incentives]
↓
[DeSci Layer — Open Collaboration & Rewards]

This flow ensures **AI → Blockchain → DeSci** operates without manual intervention.

---

## Repository Structure

NeuroGrid is composed of **three coordinated repositories**:

### 1️⃣ NeuroGrid-Core (This Repo)
**Blockchain backbone**

- Smart contracts
- Artifact registry
- Tokenized incentives
- Access control
- Deployment scripts

📌 *All AI outputs and DeSci references ultimately anchor here.*

---

### 2️⃣ MedIntel
**AI analysis engine**

- Biosignal data ingestion (synthetic/demo)
- Deterministic inference outputs
- Structured payloads for blockchain anchoring

📌 *Produces verifiable research artifacts.*

---

### 3️⃣ DeSci
**Collaboration & sharing layer**

- Dataset sharing
- Peer collaboration
- Reward signaling
- Research lifecycle visibility

📌 *Consumes on-chain artifacts and AI outputs.*

---

## Hackathon Alignment

- ✅ Open source (MIT)
- ✅ BNB Chain compatible
- ✅ Testnet-ready
- ✅ Modular & extensible
- ✅ Real-world infrastructure oriented
- ✅ No proprietary dependencies

---

## Deployment Status

### Smart Contract Deployment

**Environment**: Hardhat Local Network  
**Status**: ✅ Successfully Deployed & Tested  

| Contract | Address | Network |
|--------|--------|--------|
| NeuroGridCore | `0x5FbDB2315678afccb333f8a9c45b65d30425ab91f` | Hardhat |
| MedToken | `0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512` | Hardhat |
| ResearchIncentives | `0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0` | Hardhat |

✔ 6 transactions executed  
✔ 100% success rate  
✔ Cross-contract calls verified  

📄 Full execution proof: **[DEPLOYMENT_PROOF.md](./DEPLOYMENT_PROOF.md)**

---

## Quick Start (No-Nonsense)

```bash
npm install
npx hardhat compile
npx hardhat run scripts/deploy.mjs
npx hardhat test

