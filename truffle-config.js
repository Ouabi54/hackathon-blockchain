const { projectId, mnemonic } = require('./secrets.json');
const HDWalletProvider = require('@truffle/hdwallet-provider');

module.exports = {
  compilers: {
    solc: {
      version: "^0.5.0",
    }
  },
  networks: {
   development: { // Ganache
      host: "127.0.0.1",
      port: 9545,
      network_id: "5777"
   },
  alfajores: {
      provider: () => new HDWalletProvider(mnemonic, `https://alfajores-forno.celo-testnet.org`),
      network_id: 44787,       // Ropsten's id
      gas: 5500000,        // Ropsten has a lower block limit than mainnet
      confirmations: 2,    // # of confs to wait between deployments. (default: 0)
      timeoutBlocks: 200,  // # of blocks before a deployment times out  (minimum/default: 50)
      skipDryRun: true     // Skip dry run before migrations? (default: false for public nets )
    },
   test: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "*"
   }
  },
  // db: {
  //   enabled: false,
  //   host: "127.0.0.1",
  //   adapter: {
  //     name: "sqlite",
  //     settings: {
  //       directory: ".db"
  //     }
  //   }
  // }
};