// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Contract {
	enum Choices { Yes, No }

	// Create a Vote struct with choice and voter properties
	struct Vote {
		Choices choice;
		address voter;
	}

	// Create a public storage variable of type Vote
	Vote public vote;

	function createVote(Choices choice) external {
		// Create a new instance of Vote and store it in the storage variable
		vote = Vote({
			choice: choice,
			voter: msg.sender
		});
	}
}