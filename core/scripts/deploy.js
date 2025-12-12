const hre = require("hardhat");

async function main() {
  const [deployer] = await hre.ethers.getSigners();
  console.log("Deployer:", deployer.address);

  const ProofLedger = await hre.ethers.getContractFactory("ProofLedger");
  const proof = await ProofLedger.deploy();
  await proof.deployed();
  console.log("ProofLedger deployed to:", proof.address);
  console.log("TX hash:", proof.deployTransaction.hash);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
