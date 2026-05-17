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

    function newProposal(address _target, bytes calldata _data) external {
        proposals.push(
            Proposal({
                target: _target,
                data: _data,
                yesCount: 0,
                noCount: 0
            })
        );
    }

    function castVote(uint proposalId, bool support) external {
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
    }
}