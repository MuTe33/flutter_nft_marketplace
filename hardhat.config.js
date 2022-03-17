require("@nomiclabs/hardhat-waffle");


module.exports = {
  defaultNetwork: "hardhat",
  solidity: "0.8.4",
  settings: {
    optimizer: {
      enabled: true,
      runs: 200
    }
  }
};
