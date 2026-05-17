// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Escrow {
    address public depositor;
    address public beneficiary;
    address public arbiter;

    // Event to log when funds are approved and sent to beneficiary
    event Approved(uint256 balance);

    constructor(address _arbiter, address _beneficiary) payable {
        arbiter = _arbiter;
        beneficiary = _beneficiary;
        depositor = msg.sender;  // The deploying address
    }

    // External function that moves the contract's balance to the beneficiary
    // Only the arbiter can call this function
    function approve() external {
        require(msg.sender == arbiter, "Only arbiter can approve");
        uint256 balance = address(this).balance;
        require(balance > 0, "No funds to release");
        
        emit Approved(balance);
        payable(beneficiary).transfer(balance);
    }
}