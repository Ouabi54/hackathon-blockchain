const AmanaCFA = artifacts.require("AmanaCFA");
const AmanaProperty = artifacts.require("AmanaProperty");
const AmanaMarketplace = artifacts.require("AmanaMarketplace");
const AmanaAuthorizable = artifacts.require("AmanaAuthorizable");
const AmanaProxy = artifacts.require("AmanaProxy");


module.exports = async function (deployer, network, accounts) {
  
  //await deployer.deploy(AmanaAuthorizable, { from: "0x3FCfaC012476dD244B5C9D31CcFD83a58786ebed"}); // We deploy the authorizable contract first
  await deployer.deploy(AmanaProxy ); // We deploy the proxy contract
  await deployer.deploy(AmanaCFA, 100000000000); // We deploy the token
  await deployer.deploy(AmanaProperty ); // We deploy the NFT contract
  await deployer.deploy(AmanaMarketplace, AmanaCFA.address, AmanaProperty.address); // We deploy Marketplace

    console.log('---------------------------------');
    console.log('AmanaCFA -> ', AmanaCFA.address);
    console.log('AmanaProperty -> ', AmanaProperty.address);
    console.log('AmanaMarketplace -> ', AmanaMarketplace.address);
  
};