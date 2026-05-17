// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Contract {
	enum Choices { Yes, No }
	
	struct Vote {
		Choices choice;
		address voter;
	}
	
	// Create a public storage array of the Vote struct
	Vote[] public votes;

	function createVote(Choices choice) external {
		// Check if the caller has already voted
		require(!hasVoted(msg.sender), "Address has already voted");
		
		// Create a new vote and push it onto the votes array
		votes.push(Vote({
			choice: choice,
			voter: msg.sender
		}));
	}
	
	// Function to change an existing vote
	function changeVote(Choices newChoice) external {
		// Find the voter's vote in the array
		for (uint256 i = 0; i < votes.length; i++) {
			if (votes[i].voter == msg.sender) {
				// Update the choice on the existing vote
				votes[i].choice = newChoice;
				return; // Exit the function once found
			}
		}
		
		// If we get here, the voter doesn't have an existing vote
		revert("No existing vote found");
	}
	
	// External view function to check if an address has voted
	function hasVoted(address voter) public view returns (bool) {
		for (uint256 i = 0; i < votes.length; i++) {
			if (votes[i].voter == voter) {
				return true;
			}
		}
		return false;
	}
	
	// External view function to find the choice of an address's vote
	function findChoice(address voter) external view returns (Choices) {
		for (uint256 i = 0; i < votes.length; i++) {
			if (votes[i].voter == voter) {
				return votes[i].choice;
			}
		}
		// This line will never be reached given the requirement that 
		// we don't need to worry about the case where a vote wasn't cast
		return Choices.Yes;
	}
}