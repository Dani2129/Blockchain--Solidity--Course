// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Voting {
    struct Proposal {
        address target;
        bytes data;
        uint yesCount;
        uint noCount;
    }

    Proposal[] public proposals;

    mapping(uint => mapping(address => bool)) public votes;

    mapping(uint => mapping(address => bool)) public hasVoted;

    mapping(address => bool) public members;

    event ProposalCreated(uint proposalId);

    event VoteCast(uint proposalId, address voter);

    constructor(address[] memory _members) {
        members[msg.sender] = true;

        for (uint i = 0; i < _members.length; i++) {
            members[_members[i]] = true;
        }
    }

    function newProposal(address _target, bytes calldata _data) external {
        require(members[msg.sender], "Not a member");

        proposals.push(
            Proposal({
                target: _target,
                data: _data,
                yesCount: 0,
                noCount: 0
            })
        );

        emit ProposalCreated(proposals.length - 1);
    }

    function castVote(uint proposalId, bool support) external {
        require(members[msg.sender], "Not a member");

        Proposal storage proposal = proposals[proposalId];

        if (hasVoted[proposalId][msg.sender]) {
            bool previousVote = votes[proposalId][msg.sender];

            if (previousVote != support) {
                if (previousVote) {
                    proposal.yesCount--;
                    proposal.noCount++;
                } else {
                    proposal.noCount--;
                    proposal.yesCount++;
                }

                votes[proposalId][msg.sender] = support;
            }
        } else {
            hasVoted[proposalId][msg.sender] = true;
            votes[proposalId][msg.sender] = support;

            if (support) {
                proposal.yesCount++;
            } else {
                proposal.noCount++;
            }
        }

        if (proposal.yesCount >= 10) {
            (bool success, ) = proposal.target.call(proposal.data);
            require(success, "Execution failed");
        }

        emit VoteCast(proposalId, msg.sender);
    }
}