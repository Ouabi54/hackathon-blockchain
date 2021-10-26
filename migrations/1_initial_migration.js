const Migrations = artifacts.require("Migrations");

module.exports = async function (deployer, network, accounts) {
  //deployer.deploy(Migrations, { from: "0x3FCfaC012476dD244B5C9D31CcFD83a58786ebed"});
  deployer.deploy(Migrations);
};
