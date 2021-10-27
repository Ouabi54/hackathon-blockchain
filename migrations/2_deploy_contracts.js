const AmanaCFA = artifacts.require("AmanaCFA");
const AmanaProperty = artifacts.require("AmanaProperty");
const AmanaMarketplace = artifacts.require("AmanaMarketplace");
//const AmanaAuthorizable = artifacts.require("AmanaAuthorizable");
//const AmanaProxy = artifacts.require("AmanaProxy");
const AmanaPropertyProxy = artifacts.require("AmanaPropertyProxy");
const AmanaMarketplaceProxy = artifacts.require("AmanaMarketplaceProxy");


module.exports = async function (deployer, network, accounts) {
  
  await deployer.deploy(AmanaPropertyProxy ); // We deploy the property proxy contract
  await deployer.deploy(AmanaMarketplaceProxy ); // We deploy the marketplace proxy contract
  await deployer.deploy(AmanaCFA, 100000000000); // We deploy the token
  await deployer.deploy(AmanaProperty ); // We deploy the NFT contract
  await deployer.deploy(AmanaMarketplace, AmanaCFA.address, AmanaProperty.address); // We deploy Marketplace

    console.log('---------------------------------');
    console.log('AmanaPropertyProxy -> ', AmanaPropertyProxy.address);
    console.log('AmanaMarketplaceProxy -> ', AmanaMarketplaceProxy.address);
    console.log('AmanaCFA -> ', AmanaCFA.address);
    console.log('AmanaProperty -> ', AmanaProperty.address);
    console.log('AmanaMarketplace -> ', AmanaMarketplace.address);
  
};