require("dotenv").config();

networks: {
  opbnbTestnet: {
    url: process.env.OPBNB_TESTNET_RPC,
    accounts: [process.env.PRIVATE_KEY],
  },
},

