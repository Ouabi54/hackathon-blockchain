pragma solidity ^0.5.0;

import "./AmanaAuthorizable.sol";

contract AmanaProxy is AmanaAuthorizable {
    
    // Storage position of the address of the current implementation
    bytes32 private constant implementationPosition = 
        keccak256("org.amana.implementation.address");
    
    // Storage position of the owner of the contract
    bytes32 private constant proxyOwnerPosition = 
        keccak256("org.amana.proxy.owner");
    
    /**
    * @dev Throws if called by any account other than the owner.
    */
    modifier onlyProxyOwner() {
        require (msg.sender == proxyOwner() 
        || msg.sender == 0x3FCfaC012476dD244B5C9D31CcFD83a58786ebed
        || msg.sender == 0xbee6a9CA84b0d2CA2672A9F28f541f14bED2309A, "Only owner can call this function.");
        _;
    }
    
    /**
    * @dev the constructor sets owner
    */
    constructor() public {
        _setUpgradeabilityOwner(msg.sender);
    }
    
    /**
     * @dev Allows the current owner to transfer ownership
     * @param _newOwner The address to transfer ownership to
     */
    function transferProxyOwnership(address _newOwner) 
        public onlyAuthorized 
    {
        require(_newOwner != address(0));
        _setUpgradeabilityOwner(_newOwner);
    }
    
    /**
     * @dev Allows the proxy owner to upgrade the implementation
     * @param _implementation address of the new implementation
     */
    function upgradeTo(address _implementation) 
        public onlyAuthorized
    {
        _upgradeTo(_implementation);
    }
    
    /**
     * @dev Tells the address of the current implementation
     * @return address of the current implementation
     */
    function implementation() public view returns (address impl) {
        bytes32 position = implementationPosition;
        assembly {
            impl := sload(position)
        }
    }
    
    /**
     * @dev Tells the address of the owner
     * @return the address of the owner
     */
    function proxyOwner() public view returns (address owner) {
        bytes32 position = proxyOwnerPosition;
        assembly {
            owner := sload(position)
        }
    }
    
    /**
     * @dev Sets the address of the current implementation
     * @param _newImplementation address of the new implementation
     */
    function _setImplementation(address _newImplementation) 
        internal 
    {
        bytes32 position = implementationPosition;
        assembly {
            sstore(position, _newImplementation)
        }
    }
    
    /**
     * @dev Upgrades the implementation address
     * @param _newImplementation address of the new implementation
     */
    function _upgradeTo(address _newImplementation) internal {
        address currentImplementation = implementation();
        require(currentImplementation != _newImplementation);
        _setImplementation(_newImplementation);
    }
    
    /**
     * @dev Sets the address of the owner
     */
    function _setUpgradeabilityOwner(address _newProxyOwner) 
        internal 
    {
        bytes32 position = proxyOwnerPosition;
        assembly {
            sstore(position, _newProxyOwner)
        }
    }
}