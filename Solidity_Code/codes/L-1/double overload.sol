// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

contract Contract {
    function double(uint _value) public pure returns (uint) {
        return _value * 2;
    }

    function double(uint _value1, uint _value2) external pure returns (uint, uint) {
        return (double(_value1), double(_value2));
    }
}