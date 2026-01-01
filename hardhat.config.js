require("@nomiclabs/hardhat-waffle");
require("dotenv").config();

module.exports = {
  solidity: "0.8.19",
  networks: {
    testnet: {
      url: process.env.BNB_RPC_URL,
      accounts: [process.env.PRIVATE_KEY],
      gasPrice: 20000000000,  // Optimized for lower costs

      require("solidity-coverage");

require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

module.exports = {
  solidity: "0.8.19",
  networks: {
    bnbTestnet: {
      url: "https://data-seed-prebsc-1-s1.binance.org:8545/",
      accounts: [process.env.DEPLOYER_PRIVATE_KEY],
      chainId: 97
    }
  }
};
        
module.exports = {
  solidity: "0.8.20",
  networks: {
    hardhat: {}
  }
};

    },
  },
  // Add for future scalability: plugins like hardhat-gas-reporter
};
