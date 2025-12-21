require("@nomiclabs/hardhat-waffle");
require("dotenv").config();

module.exports = {
  solidity: "0.8.19",
  networks: {
    testnet: {
      url: process.env.BNB_RPC_URL,
      accounts: [process.env.PRIVATE_KEY],
      gasPrice: 20000000000,  // Optimized for lower costs
    },
  },
  // Add for future scalability: plugins like hardhat-gas-reporter
};
