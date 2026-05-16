// SPDX-License-Identifier: MIT
pragma solidity 0.8.35;

contract Contract {
    function filterEven(uint[] calldata numbers) external pure returns(uint[] memory) {
        // First pass: count how many even numbers
        uint evenCount = 0;
        for(uint i = 0; i < numbers.length; i++) {
            if(numbers[i] % 2 == 0) {
                evenCount++;
            }
        }
        
        // Create a memory array with exactly the size needed
        uint[] memory evenNumbers = new uint[](evenCount);
        
        // Second pass: fill the array with even numbers
        uint index = 0;
        for(uint i = 0; i < numbers.length; i++) {
            if(numbers[i] % 2 == 0) {
                evenNumbers[index] = numbers[i];
                index++;
            }
        }
        
        return evenNumbers;
    }
}