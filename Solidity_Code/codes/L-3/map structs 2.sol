// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
	struct User {
		uint balance;
		bool isActive;
	}
	
	// Create a public mapping that maps an address to a User struct
	mapping(address => User) public users;
	
	// External function to create a new user
	function createUser() external {
		// Check if the caller is not already an active user
		require(!users[msg.sender].isActive, "User already exists and is active");
		
		// Create a new user and associate it with the msg.sender address
		users[msg.sender] = User({
			balance: 100,
			isActive: true
		});
	}
	
	// External function to transfer tokens between users
	function transfer(address recipient, uint amount) external {
		// Ensure the sender has an active user
		require(users[msg.sender].isActive, "Sender does not have an active user");
		
		// Ensure the recipient has an active user
		require(users[recipient].isActive, "Recipient does not have an active user");
		
		// Ensure the sender has enough balance to make the transfer
		require(users[msg.sender].balance >= amount, "Insufficient balance");
		
		// Transfer the amount from sender to recipient
		users[msg.sender].balance -= amount;
		users[recipient].balance += amount;
	}
}