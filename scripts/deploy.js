const { ethers } = require("hardhat");

async function main() {
  console.log("Deploying NeuroGrid-Core contracts...");

  const [deployer] = await ethers.getSigners();
  console.log("Deployer:", deployer.address);

  // ---- MedToken ----
  const MedToken = await ethers.getContractFactory("MedToken");
  const medToken = await MedToken.deploy();
  await medToken.waitForDeployment();

  const medTokenAddress = await medToken.getAddress();
  console.log("MedToken deployed to:", medTokenAddress);

  // ---- NeuroGridCore ----
  const NeuroGridCore = await ethers.getContractFactory("NeuroGridCore");
  const neuroGridCore = await NeuroGridCore.deploy(medTokenAddress);
  await neuroGridCore.waitForDeployment();

  const neuroGridCoreAddress = await neuroGridCore.getAddress();
  console.log("NeuroGridCore deployed to:", neuroGridCoreAddress);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
