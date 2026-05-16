// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    // Changed visibility from external to public so it can be called internally
    function double(uint x) public pure returns(uint) {
        return x * 2;
    }

    // Overloaded function that takes two uints and returns both doubled
    function double(uint x, uint y) external pure returns(uint, uint) {
        return (double(x), double(y));
    }
}