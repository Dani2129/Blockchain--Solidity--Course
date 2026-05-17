// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    function double(uint x) external pure returns(uint) {
        return x * 2;
    }
}