// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Contract {
	enum Choices { Yes, No }

	struct Vote {
		Choices choice;
		address voter;
	}
	
	// External view function that creates and returns a Vote instance
	function createVote(Choices choice) external view returns (Vote memory) {
		// Create a new Vote in memory and return it
		return Vote({
			choice: choice,
			voter: msg.sender
		});
	}
}