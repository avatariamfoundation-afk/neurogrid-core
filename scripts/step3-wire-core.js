const hre = require("hardhat");

async function main() {
  const [deployer] = await hre.ethers.getSigners();

  console.log("Executor:", deployer.address);

  const CORE_ADDRESS = "0xDc64a140Aa3E981100a9becA4E685f962f0cF6C9";
  const MEDTOKEN_ADDRESS = "0xCf7Ed3AccA5a467e9e704C703E8D87F634fB0Fc9";

  const core = await hre.ethers.getContractAt(
    "contracts/NeuroGridCore.sol:NeuroGridCore",
    CORE_ADDRESS
  );

  const medToken = await hre.ethers.getContractAt(
    "MedToken",
    MEDTOKEN_ADDRESS
  );

  console.log("Core:", await core.getAddress());
  console.log("MedToken:", await medToken.getAddress());

  // sanity check
  const owner = await core.owner();
  console.log("Core owner:", owner);

  console.log("STEP 3 COMPLETE");
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
