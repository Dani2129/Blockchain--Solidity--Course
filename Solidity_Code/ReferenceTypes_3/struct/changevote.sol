// SPDX-License-Identifier: MIT
pragma solidity 0.8.35;

contract Contract {
    enum Choices { Yes, No }
    
    struct Vote {
        Choices choice;
        address voter;
    }
    
    Vote[] public votes;

    function createVote(Choices choice) external {
        require(!hasVoted(msg.sender), "Address has already voted");
        votes.push(Vote(choice, msg.sender));
    }

    function changeVote(Choices newChoice) external {
        for(uint i = 0; i < votes.length; i++) {
            if(votes[i].voter == msg.sender) {
                votes[i].choice = newChoice;
                return;
            }
        }
        revert("Voter has not cast a vote");
    }

    function hasVoted(address voter) public view returns(bool) {
        for(uint i = 0; i < votes.length; i++) {
            if(votes[i].voter == voter) {
                return true;
            }
        }
        return false;
    }

    function findChoice(address voter) external view returns(Choices) {
        for(uint i = 0; i < votes.length; i++) {
            if(votes[i].voter == voter) {
                return votes[i].choice;
            }
        }
        revert("Voter not found");
    }
}