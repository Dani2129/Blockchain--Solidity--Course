// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Contract {
    // Public dynamic array to store even numbers
    uint256[] public evenNumbers;

    // External function that filters even numbers from input array
    function filterEven(uint256[] memory numbers) external {
    
        delete evenNumbers;
        
        // Loop through the input array
        for (uint256 i = 0; i < numbers.length; i++) {
            // Check if the number is even (divisible by 2)
            if (numbers[i] % 2 == 0) {
                // Push the even number to the storage array
                evenNumbers.push(numbers[i]);
            }
        }
    }
}