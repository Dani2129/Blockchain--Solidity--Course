// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Voting {
    enum VoteType { None, Yes, No }

    struct Proposal {
        address target;
        bytes data;
        uint yesCount;
        uint noCount;
    }

    Proposal[] public proposals;

    // proposalId => (voter => VoteType)
    mapping(uint => mapping(address => VoteType)) public votes;

    function newProposal(address target, bytes calldata data) external {
        proposals.push(Proposal(target, data, 0, 0));
    }

    function castVote(uint proposalId, bool support) external {
        require(proposalId < proposals.length, "Invalid proposal ID");

        Proposal storage proposal = proposals[proposalId];
        VoteType currentVote = votes[proposalId][msg.sender];

        // New vote type based on support
        VoteType newVote = support ? VoteType.Yes : VoteType.No;

        // If already voted the same way, do nothing
        if (currentVote == newVote) return;

        // Remove old vote if it exists
        if (currentVote == VoteType.Yes) {
            proposal.yesCount--;
        } else if (currentVote == VoteType.No) {
            proposal.noCount--;
        }

        // Add new vote
        if (newVote == VoteType.Yes) {
            proposal.yesCount++;
        } else {
            proposal.noCount++;
        }

        // Update stored vote
        votes[proposalId][msg.sender] = newVote;
    }
}