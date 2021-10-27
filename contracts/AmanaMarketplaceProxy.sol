pragma solidity ^0.5.0;

import "./AmanaProxy.sol";

contract AmanaMarketplaceProxy is AmanaProxy {
    
    // Storage position of the address of the current implementation
    bytes32 private constant implementationPosition = 
        keccak256("org.amana.marketplace.implementation.address");
    
    // Storage position of the owner of the contract
    bytes32 private constant proxyOwnerPosition = 
        keccak256("org.amana.marketplace.proxy.owner");
    
    
}