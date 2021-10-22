const AmanaCFA = artifacts.require("AmanaCFA");
const AmanaProperty = artifacts.require("AmanaProperty");
const AmanaMarketplace = artifacts.require("AmanaMarketplace");


module.exports = async function (deployer, network, accounts) {
  // deployment steps
  await deployer.deploy(AmanaCFA, 100000000000);
  await deployer.deploy(AmanaProperty);
  await deployer.deploy(AmanaMarketplace);
};