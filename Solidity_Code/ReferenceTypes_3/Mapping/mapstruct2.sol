// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    struct User {
        uint balance;
        bool isActive;
    }

    // Public mapping from address to User struct
    mapping(address => User) public users;

    // Create a new user for the caller
    function createUser() external {
        // Require that the caller is not already an active user
        require(!users[msg.sender].isActive, "User already exists and is active");

        // Create new user with balance 100 and active true
        users[msg.sender] = User({
            balance: 100,
            isActive: true
        });
    }

    // Transfer amount from msg.sender to recipient
    function transfer(address recipient, uint amount) external {
        // Ensure sender and recipient are active users
        require(users[msg.sender].isActive, "Sender is not an active user");
        require(users[recipient].isActive, "Recipient is not an active user");

        // Ensure sender has enough balance
        require(users[msg.sender].balance >= amount, "Insufficient balance");

        // Perform the transfer
        users[msg.sender].balance -= amount;
        users[recipient].balance += amount;
    }
}