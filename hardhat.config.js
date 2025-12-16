
require("dotenv").config();

module.exports = {
  solidity: "0.8.20",
  networks: {
    opbnbTestnet: {
      url: process.env.OPBNB_RPC,
      accounts: [process.env.PRIVATE_KEY]
    }
  }
};
