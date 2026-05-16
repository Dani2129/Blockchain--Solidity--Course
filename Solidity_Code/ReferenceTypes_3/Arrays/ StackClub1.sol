// SPDX-License-Identifier: MIT
pragma solidity 0.8.35;

contract StackClub {
    address[] public members;

    function addMember(address newMember) external {
        members.push(newMember);
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