// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    // Create a public mapping that maps an address to a bool
    mapping(address => bool) public members;
    
    // External function to add a member
    function addMember(address member) external {
        // Add the address as a member by setting the bool to true
        members[member] = true;
    }
    
    // External function to remove a member
    function removeMember(address member) external {
        // Set the member's value to false
        members[member] = false;
    }
    
    // External view function to check if an address is a member
    function isMember(address account) external view returns (bool) {
        // Return the bool value from the members mapping
        return members[account];
    }
}