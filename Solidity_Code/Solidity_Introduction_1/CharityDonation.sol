// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    address public owner;
    address public charity;

    constructor(address _charity) {
        owner = msg.sender;
        charity = _charity;
    }

    receive() external payable {
        // This function allows the contract to receive Ether
        // without any calldata, and the Ether is automatically
        // added to the contract's balance
    }

    function tip() public payable {
        (bool success, ) = owner.call{ value: msg.value }("");
        require(success, "Transfer failed");
    }

    function donate() public {
        uint256 contractBalance = address(this).balance;
        require(contractBalance > 0, "No funds to donate");
        
        (bool success, ) = charity.call{ value: contractBalance }("");
        require(success, "Donation failed");
    }
}