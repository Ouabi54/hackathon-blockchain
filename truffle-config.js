const { projectId, mnemonic } = require('./secrets.json');
const HDWalletProvider = require('@truffle/hdwallet-provider');

module.exports = {
  compilers: {
    solc: {
      version: "^0.5.0",
    }
  },
  networks: {
    alfajores: {
        //provider: () => new HDWalletProvider(mnemonic, `https://alfajores-forno.celo-testnet.org`),
        provider: function() {
          //return new HDWalletProvider(process.env.MNEMONIC, "https://alfajores-forno.celo-testnet.org")
          //return new HDWalletProvider(mnemonic, "https://alfajores-forno.celo-testnet.org")
          //return new HDWalletProvider("enter celo priv key ( not mnemonic ) to use truffle console", "https://alfajores-forno.celo-testnet.org")
          return new HDWalletProvider("f6d9d5a76da685213f7d3e70bb2f2cc904d532cfe61212467bbb0982fe17267d", "https://alfajores-forno.celo-testnet.org")
        },
        //from : "0x3FCfaC012476dD244B5C9D31CcFD83a58786ebed",
        network_id: 44787,       // Alfajores's id
        gas: 5500000,        // Alfajores has a lower block limit than mainnet
        confirmations: 2,    // # of confs to wait between deployments. (default: 0)
        timeoutBlocks: 200,  // # of blocks before a deployment times out  (minimum/default: 50)
        skipDryRun: true     // Skip dry run before migrations? (default: false for public nets )
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
