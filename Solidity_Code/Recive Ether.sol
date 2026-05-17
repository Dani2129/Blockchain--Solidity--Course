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
    }
    
    function tip() public payable {
        payable(owner).transfer(msg.value);
    }
    
    function donate() public {
        selfdestruct(payable(charity));
    }
}