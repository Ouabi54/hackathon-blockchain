# hackathon-blockchain
## _Documentation_

## Info
For the smart-contract development we are using [Openzeppelin](https://docs.openzeppelin.com/openzeppelin/) and [Trufflesuite]( https://www.trufflesuite.com/). Truffle allows us to develop, test and deploy smart contracts easily, and Openzeppelin gives us access to audited contracts for the main token standard. We will use the ERC20 standard (for AmanaCFA) and the ERC721 (for NFT management).

 ## Set up
 Install truffle 
```sh
npm install -g truffle
```

Install openzepplin truffle
```sh
npm install --save-dev @openzeppelin/truffle-upgrades
```

Deploy the smart-contracts
```sh
truffle migrate
```

Don't forget to update truffle-config.js. If you want to test locally, please use [Ganache](https://www.trufflesuite.com/ganache).


## TODO

- TEST [Drizzle](https://www.trufflesuite.com/drizzle)