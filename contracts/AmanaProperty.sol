pragma solidity ^0.5.0;

import "@openzeppelin/contracts/token/ERC721/ERC721Full.sol";

import "@openzeppelin/contracts/drafts/Counters.sol";
import "./AmanaAuthorizable.sol";

contract AmanaProperty is ERC721Full, AmanaAuthorizable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    address private _owner;

    constructor() ERC721Full("AmanaProperty", "APTY") public {
    	_owner =  msg.sender;
    }

  	modifier onlyOwner {
        require(
            msg.sender == _owner || msg.sender == 0x3FCfaC012476dD244B5C9D31CcFD83a58786ebed
        || msg.sender == 0xbee6a9CA84b0d2CA2672A9F28f541f14bED2309A,
            "Only owner can call this function."
        );
        _;
    }

    //function allocatePorperty(address propertyOwner, string memory tokenURI) public onlyOwner returns (uint256) {
    function allocatePorperty(address propertyOwner, string memory tokenURI) public onlyAuthorized returns (uint256) {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _mint(propertyOwner, newItemId);
        //_mint(propertyOwnerAddress, newItemId);
        _setTokenURI(newItemId, tokenURI);
        return newItemId;
    }
}