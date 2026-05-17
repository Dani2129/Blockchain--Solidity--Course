// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
	enum ConnectionTypes { 
		Unacquainted,
		Friend,
		Family
	}
	
	// Create a public nested mapping: address => (address => ConnectionTypes)
	mapping(address => mapping(address => ConnectionTypes)) public connections;

	function connectWith(address other, ConnectionTypes connectionType) external {
		// Create a connection from msg.sender to the other address
		connections[msg.sender][other] = connectionType;
	}
}