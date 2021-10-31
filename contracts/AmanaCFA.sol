pragma solidity ^0.5.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Detailed.sol";
import "./AmanaAuthorizable.sol";


contract AmanaCFA is ERC20, ERC20Detailed, AmanaAuthorizable {
    constructor(uint256 initialSupply) ERC20Detailed("AmanaCFA", "ACFA", 5) public {
        _mint(msg.sender, initialSupply**18);
    }
}