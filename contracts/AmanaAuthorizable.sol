pragma solidity ^0.5.0;

import "@openzeppelin/contracts/ownership/Ownable.sol";

contract AmanaAuthorizable is Ownable {


    // Storage position of the owner of the contract
    // mapping(address => bool) private proxyOwnerPosition = {
    //     keccak256("org.amana.proxy.owner"): true
    // }
    mapping(address => bool) private proxyOwnerPosition ;

    mapping(address => bool) public authorized;

    modifier onlyAuthorized() {
        require(authorized[msg.sender] || owner() == msg.sender);
        _;
    }


    /**
     * @dev Tells the address of the owner
     * @return the address of the owner
     */
    function proxyOwner() public view returns (address owner) {
        mapping(address => bool) storage position = proxyOwnerPosition;
        assembly {
            owner := sload(position_slot)
        }
    }

    function addAuthorized(address _toAdd) onlyOwner public {
        require(_toAdd != address(0));
        authorized[_toAdd] = true;
        proxyOwnerPosition[_toAdd] = true;
    }

    function removeAuthorized(address _toRemove) onlyOwner public {
        require(_toRemove != address(0));
        require(_toRemove != msg.sender);
        authorized[_toRemove] = false;
        proxyOwnerPosition[_toRemove] = false;
    }

}