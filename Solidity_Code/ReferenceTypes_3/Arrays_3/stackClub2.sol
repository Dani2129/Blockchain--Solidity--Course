// SPDX-License-Identifier: MIT
pragma solidity 0.8.35;

contract StackClub {
    address[] public members;

    constructor() {
        members.push(msg.sender);
    }

    modifier onlyMember() {
        bool isExistingMember = false;
        for(uint i = 0; i < members.length; i++) {
            if(members[i] == msg.sender) {
                isExistingMember = true;
                break;
            }
        }
        require(isExistingMember, "Only existing members can call this function");
        _;
    }

    function addMember(address newMember) external onlyMember {
        members.push(newMember);
    }

    function removeLastMember() external onlyMember {
        require(members.length > 0, "No members to remove");
        members.pop();
    }

    function isMember(address target) public view returns(bool) {
        for(uint i = 0; i < members.length; i++) {
            if(members[i] == target) {
                return true;
            }
        }
        return false;
    }
}