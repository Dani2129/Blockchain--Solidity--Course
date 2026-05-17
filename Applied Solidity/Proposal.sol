// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Voting {
    struct Proposal {
        address target;
        bytes data;
        uint yesCount;
        uint noCount;
    }

    // Public array of proposals
    Proposal[] public proposals;

    // Create a new proposal
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
}