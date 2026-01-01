async function main() {
  const coreAddress = process.env.CORE_ADDRESS;
  if (!coreAddress) throw new Error("CORE_ADDRESS not set");

  const Validator = await ethers.getContractFactory("ValidatorModule");
  const validator = await Validator.deploy(coreAddress);

  await validator.deployed();

  console.log("ValidatorModule deployed to:", validator.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

