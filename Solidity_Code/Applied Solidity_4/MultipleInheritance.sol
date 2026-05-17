// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Transferable {
    // Define the owner address variable
    address public owner;
    
    // Constructor sets the deployer as the owner
    constructor() {
        owner = msg.sender;
    }
    
    // Modifier to restrict functions to only the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }
    
    // Transfer ownership to a new address
    function transfer(address newOwner) external onlyOwner {
        require(newOwner != address(0), "New owner cannot be zero address");
        owner = newOwner;
    }
}