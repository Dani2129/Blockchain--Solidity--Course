// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Escrow {
    address public depositor;
    address public beneficiary;
    address public arbiter;

    // Constructor takes arbiter and beneficiary addresses (in that order)
    // Depositor is the address that deploys the contract (msg.sender)
    constructor(address _arbiter, address _beneficiary) payable {
        arbiter = _arbiter;
        beneficiary = _beneficiary;
        depositor = msg.sender;  // The deploying address
    }
}