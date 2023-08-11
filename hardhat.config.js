require("@nomicfoundation/hardhat-toolbox");
require('hardhat-abi-exporter');

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.19",
  networks: {
    testnet: {
      // Keep private key secret:891880825389de461dc7e7230b1769507efd632741649b2f9dd15d9e0261f5f4
      accounts: ['891880825389de461dc7e7230b1769507efd632741649b2f9dd15d9e0261f5f4'],
      url: "https://rpc-mumbai.maticvigil.com"
    }
  },
  abiExporter: {
    path: "./abi",
    clear: false,
    flat: true,
    pretty: false,
    runOnCompile: true,
  },
};
