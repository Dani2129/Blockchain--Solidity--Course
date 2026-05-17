// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Contract {
    function filterEven(uint256[] memory numbers) external pure returns (uint256[] memory) {
        // Create a temporary array with maximum possible size
        uint256[] memory temp = new uint256[](numbers.length);
        uint256 count = 0;
        
        // One pass: add even numbers to temp array
        for (uint256 i = 0; i < numbers.length; i++) {
            if (numbers[i] % 2 == 0) {
                temp[count] = numbers[i];
                count++;
            }
        }
        
        // Create final array with exact size
        uint256[] memory evenNumbers = new uint256[](count);
        for (uint256 i = 0; i < count; i++) {
            evenNumbers[i] = temp[i];
        }
        
        return evenNumbers;
    }
}