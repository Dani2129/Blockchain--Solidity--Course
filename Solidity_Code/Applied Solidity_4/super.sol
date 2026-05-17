// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "./Hero.sol";

// Create Mage contract that inherits from Hero with health = 50
contract Mage is Hero(50) {
    // Inherits everything from Hero contract with initial health 50
    
    // Override the attack function for Mage - visibility must match (public)
    function attack(Enemy enemy) public override {
        // For Mage, use Spell attack type
        enemy.takeAttack(AttackTypes.Spell);
        // Call the base contract's attack function
        super.attack(enemy);
    }
}

// Create Warrior contract that inherits from Hero with health = 200
contract Warrior is Hero(200) {
    // Inherits everything from Hero contract with initial health 200
    
    // Override the attack function for Warrior - visibility must match (public)
    function attack(Enemy enemy) public override {
        // For Warrior, use Brawl attack type
        enemy.takeAttack(AttackTypes.Brawl);
        // Call the base contract's attack function
        super.attack(enemy);
    }
}