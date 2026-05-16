// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Sidekick {
    function makeContact(address hero) external {
        // Send calldata that doesn't match any function signature to trigger fallback
        // A single byte or empty bytes would work, but here we send a random 4-byte value
        bytes memory data = abi.encodePacked(bytes4(keccak256("nonexistentFunction()")));
        
        (bool success, ) = hero.call(data);
        require(success, "Fallback call failed");
    }
}