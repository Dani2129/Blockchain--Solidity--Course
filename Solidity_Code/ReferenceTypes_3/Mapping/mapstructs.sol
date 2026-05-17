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
}