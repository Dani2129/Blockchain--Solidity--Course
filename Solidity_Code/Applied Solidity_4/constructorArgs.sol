// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "./Hero.sol";

// Create Mage contract that inherits from Hero with health = 50
contract Mage is Hero(50) {
    // Inherits everything from Hero contract with initial health 50
}

// Create Warrior contract that inherits from Hero with health = 200
contract Warrior is Hero(200) {
    // Inherits everything from Hero contract with initial health 200
}