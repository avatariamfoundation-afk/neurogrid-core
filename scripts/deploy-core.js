async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying with:", deployer.address);

  const Core = await ethers.getContractFactory("NeuroGridCore");
  const core = await Core.deploy(deployer.address);

  await core.deployed();

  console.log("NeuroGridCore deployed to:", core.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

