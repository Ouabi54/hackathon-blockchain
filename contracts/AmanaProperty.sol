pragma solidity ^0.5.0;

import "@openzeppelin/contracts/token/ERC721/ERC721Full.sol";
import "@openzeppelin/contracts/drafts/Counters.sol";

contract AmanaProperty is ERC721Full {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    address private _owner;

    constructor() ERC721Full("AmanaProperty", "APTY") public {
    	_owner =  msg.sender;
    }

  	modifier onlyOwner {
        require(
            msg.sender == _owner,
            "Only owner can call this function."
        );
        _;
    }

    function allocatePorperty(address propertyOwner, string memory tokenURI) public onlyOwner returns (uint256) {
        _tokenIds.increment();

        uint256 newItemId = _tokenIds.current();
        _mint(propertyOwner, newItemId);
        _setTokenURI(newItemId, tokenURI);

        return newItemId;
    }
}