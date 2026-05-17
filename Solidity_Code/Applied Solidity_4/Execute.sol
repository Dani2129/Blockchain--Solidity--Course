// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Voting {
    enum VoteType { None, Yes, No }

    struct Proposal {
        address target;
        bytes data;
        uint yesCount;
        uint noCount;
        bool executed;
    }

    Proposal[] public proposals;

    // proposalId => (voter => VoteType)
    mapping(uint => mapping(address => VoteType)) public votes;

    // Track voting members
    mapping(address => bool) public isMember;

    // Events
    event ProposalCreated(uint proposalId);
    event VoteCast(uint indexed proposalId, address indexed voter);
    event ProposalExecuted(uint indexed proposalId);

    // Constructor - takes array of addresses and adds them plus deployer as members
    constructor(address[] memory initialMembers) {
        // Add the deployer as a member
        isMember[msg.sender] = true;
        
        // Add all initial members from the array
        for (uint i = 0; i < initialMembers.length; i++) {
            isMember[initialMembers[i]] = true;
        }
    }

    // Modifier to check if caller is a member
    modifier onlyMember() {
        require(isMember[msg.sender], "Not a voting member");
        _;
    }

    function newProposal(address target, bytes calldata data) external onlyMember {
        uint proposalId = proposals.length;
        proposals.push(Proposal(target, data, 0, 0, false));
        emit ProposalCreated(proposalId);
    }

    function castVote(uint proposalId, bool support) external onlyMember {
        require(proposalId < proposals.length, "Invalid proposal ID");

        Proposal storage proposal = proposals[proposalId];
        require(!proposal.executed, "Proposal already executed");

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

        // Execute if 10 or more yes votes and not already executed
        if (proposal.yesCount >= 10 && !proposal.executed) {
            executeProposal(proposalId);
        }
    }

    function executeProposal(uint proposalId) internal {
        Proposal storage proposal = proposals[proposalId];
        require(!proposal.executed, "Proposal already executed");
        
        // Execute the vote by sending data to target address
        (bool success, ) = proposal.target.call(proposal.data);
        require(success, "Execution failed");
        
        proposal.executed = true;
        emit ProposalExecuted(proposalId);
    }
}