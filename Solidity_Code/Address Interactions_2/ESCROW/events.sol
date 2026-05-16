// SPDX-License-Identifier: MIT
pragma solidity 0.8.35;

contract Escrow {
    address public depositor;
    address public beneficiary;
    address public arbiter;

    event Approved(uint balance);

    constructor(address _arbiter, address _beneficiary) payable {
        depositor = msg.sender;
        arbiter = _arbiter;
        beneficiary = _beneficiary;
    }

    function approve() external {
        require(msg.sender == arbiter, "Only arbiter can approve");
        
        uint256 balance = address(this).balance;
        require(balance > 0, "No funds to transfer");
        
        (bool success, ) = beneficiary.call{ value: balance }("");
        require(success, "Transfer failed");

        emit Approved(balance);
    }
}