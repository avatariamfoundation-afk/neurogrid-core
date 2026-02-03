const hre = require("hardhat");

async function main() {
  const [deployer] = await hre.ethers.getSigners();

  console.log("Deploying to opBNB Testnet");
  console.log("Deployer:", deployer.address);
  console.log("Balance:", (await deployer.getBalance()).toString());

  // 1. Deploy MedToken
  const MedToken = await hre.ethers.getContractFactory(
    "contracts/MedToken.sol:MedToken"
  );
  const medToken = await MedToken.deploy();
  await medToken.waitForDeployment();

  const medTokenAddr = await medToken.getAddress();
  console.log("MedToken:", medTokenAddr);

  // 2. Deploy NeuroGridCore
  const Core = await hre.ethers.getContractFactory(
    "contracts/NeuroGridCore.sol:NeuroGridCore"
  );
  const core = await Core.deploy(medTokenAddr);
  await core.waitForDeployment();

  console.log("NeuroGridCore:", await core.getAddress());
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
