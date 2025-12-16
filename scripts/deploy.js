
const hre = require("hardhat");

async function main() {
  const NeuroGridCore = await hre.ethers.getContractFactory("NeuroGridCore");
  const contract = await NeuroGridCore.deploy();
  await contract.deployed();

  console.log("NeuroGridCore deployed to:", contract.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
