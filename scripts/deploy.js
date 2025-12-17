const hre = require("hardhat");

async function main() {
  console.log("Deploying NeuroGridCore...");

  const NeuroGridCore = await hre.ethers.getContractFactory("NeuroGridCore");
  const neuroGridCore = await NeuroGridCore.deploy();

  await neuroGridCore.waitForDeployment();

  const address = await neuroGridCore.getAddress();

  console.log("NeuroGridCore deployed to:", address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
