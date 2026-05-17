// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Contract {
    // More gas-efficient version without loop
    function sum(uint256[5] memory numbers) external pure returns (uint256) {
        return numbers[0] + numbers[1] + numbers[2] + numbers[3] + numbers[4];
    }
}