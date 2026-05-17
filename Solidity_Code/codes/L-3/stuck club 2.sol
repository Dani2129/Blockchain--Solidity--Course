// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract StackClub {
    // Dynamic array to store member addresses
    address[] public members;
    
    // Constructor that adds the deployer as the first member
    constructor() {
        members.push(msg.sender);
    }
    
    // Modifier to restrict functions to existing members only
    modifier onlyMember() {
        require(isMember(msg.sender), "Caller is not a member");
        _;
    }
    
    // External function to add a new member (only existing members can call)
    function addMember(address newMember) external onlyMember {
        // Prevent duplicate members
        require(!isMember(newMember), "Address is already a member");
        members.push(newMember);
    }
    
    // Function to remove the last member (only existing members can call)
    function removeLastMember() external onlyMember {
        // Ensure there's at least one member to remove
        require(members.length > 0, "No members to remove");
        
        // Remove the last member
        members.pop();
    }
    
    // Public view function to check if an address is a member
    function isMember(address account) public view returns (bool) {
        // Loop through all members to find a match
        for (uint256 i = 0; i < members.length; i++) {
            if (members[i] == account) {
                return true;
            }
        }
        return false;
    }
    
    // Optional: Get the number of members
    function getMemberCount() external view returns (uint256) {
        return members.length;
    }
}