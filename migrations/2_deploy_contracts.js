const AmanaCFA = artifacts.require("AmanaCFA");
const AmanaProperty = artifacts.require("AmanaProperty");
const AmanaMarketplace = artifacts.require("AmanaMarketplace");


module.exports = async function (deployer, network, accounts) {
  await deployer.deploy(AmanaCFA, 100000000000); // We deploy the token
  await deployer.deploy(AmanaProperty); // We deploy the NFT contract
  await deployer.deploy(AmanaMarketplace, AmanaCFA.address, AmanaProperty.address); // We deploy Marketplace

  console.log('---------------------------------');
  console.log('AmanaCFA -> ', AmanaCFA.address);
  console.log('AmanaProperty -> ', AmanaProperty.address);
  console.log('AmanaMarketplace -> ', AmanaMarketplace.address);
};