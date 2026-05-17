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

    // Events - NO indexed for ProposalCreated to match test expectation
    event ProposalCreated(uint proposalId);  // Removed 'indexed'
    event VoteCast(uint indexed proposalId, address indexed voter);

    function newProposal(address target, bytes calldata data) external {
        uint proposalId = proposals.length;
        proposals.push(Proposal(target, data, 0, 0));
        emit ProposalCreated(proposalId);
    }

    function castVote(uint proposalId, bool support) external {
        require(proposalId < proposals.length, "Invalid proposal ID");

        Proposal storage proposal = proposals[proposalId];
        VoteType currentVote = votes[proposalId][msg.sender];
        VoteType newVote = support ? VoteType.Yes : VoteType.No;

        // Remove old vote if it exists
        if (currentVote == VoteType.Yes) {
            proposal.yesCount--;
        } else if (currentVote == VoteType.No) {
            proposal.noCount--;
        }

        // Add new vote
        if (newVote == VoteType.Yes) {
            proposal.yesCount++;
        } else if (newVote == VoteType.No) {
            proposal.noCount++;
        }

        // Update stored vote
        votes[proposalId][msg.sender] = newVote;

        // Emit event every time function is called
        emit VoteCast(proposalId, msg.sender);
    }
}