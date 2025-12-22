const { ethers } = require("hardhat");
const fs = require('fs');
const configPath = './config/app.js';

async function main() {
  console.log("Deploying NeuroGrid-Core contracts...");

  const MedToken = await ethers.getContractFactory("MedToken");
  const neuroToken = await MedToken.deploy();
  await neuroToken.deployed();
  console.log("NeuroToken deployed at:", neuroToken.address);

  const NeuroGrid = await ethers.getContractFactory("NeuroGrid");
  const neuroGrid = await NeuroGrid.deploy(neuroToken.address);
  await neuroGrid.deployed();
  console.log("NeuroGrid deployed at:", neuroGrid.address);

  // Update config with token address
  const config = require(configPath);
  config.tokenContractAddress = neuroToken.address;
  fs.writeFileSync(configPath, `module.exports = ${JSON.stringify(config, null, 2)};`);
}

main()
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
