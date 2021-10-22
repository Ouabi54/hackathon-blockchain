const AmanaCFA = artifacts.require("AmanaCFA");

module.exports = async function (deployer, network, accounts) {
  // deployment steps
  await deployer.deploy(AmanaCFA, 100000000000);
};