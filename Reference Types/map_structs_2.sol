// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    struct User {
        uint balance;
        bool isActive;
    }

    mapping(address => User) public users;

    function createUser() external {
        require(!users[msg.sender].isActive, "User already exists");

        users[msg.sender] = User({
            balance: 100,
            isActive: true
        });
    }

    function transfer(address recipient, uint amount) external {
        require(users[msg.sender].isActive, "Sender inactive");
        require(users[recipient].isActive, "Recipient inactive");
        require(users[msg.sender].balance >= amount, "Insufficient balance");

        users[msg.sender].balance -= amount;
        users[recipient].balance += amount;
    }
}