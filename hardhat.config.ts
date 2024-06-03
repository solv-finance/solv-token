import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "hardhat-deploy";
import "hardhat-tracer";

import * as dotenv from 'dotenv';
dotenv.config()

const config: HardhatUserConfig = {
  solidity: {
    compilers: [
      {
        version: "0.8.20",
        settings: {
          optimizer: {
            enabled: true,
            runs: 20,
          },
        },
      },
    ]
  },

  namedAccounts: {
    deployer: 0
  },

  networks: {
    hardhat: {},
    localhost: {},
    sepolia: {
      url: process.env.SEPOLIA_URL || `https://sepolia.infura.io/v3/${process.env.INFURA_KEY}`,
      accounts:
        process.env.PRIVATE_KEY !== undefined ? [process.env.PRIVATE_KEY] : [],
    },
    mainnet: {
      url: process.env.GOERLI_URL || `https://mainnet.infura.io/v3/${process.env.INFURA_KEY}`,
      accounts:
        process.env.PRIVATE_KEY !== undefined ? [process.env.PRIVATE_KEY] : [],
    },
  },

  etherscan: {
    apiKey: {
      sepolia: process.env.ETHERSCAN_API_KEY || '',
    },
  }
};

export default config;
