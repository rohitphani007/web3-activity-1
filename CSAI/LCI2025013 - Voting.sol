// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;
contract Voting {
struct Candidate {
        string name;
        uint voteCount;
    }
     address public owner;
    bool public votingOpen = false;

    Candidate[] public candidates;                      
    mapping(address => bool) public hasVoted;           
    }
    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner");
        _;
    }
    modifier canVote() {
        require(votingOpen == true, "Voting is closed");
        require(hasVoted[msg.sender] == false, "You already voted!");
        _;
    }
     function addCandidate(string memory _name) public onlyOwner {
        require(votingOpen == false, "Cannot add candidates during voting!");

        candidates.push(Candidate(_name, 0));
    }
    function startVoting() public onlyOwner {
        require(candidates.length > 0, "No candidates added!");
        votingOpen = true;
    }
    function stopVoting() public onlyOwner {
        votingOpen = false;
    }
     function vote(uint candidateIndex) public canVote {
        require(candidateIndex < candidates.length, "Invalid candidate index");

        candidates[candidateIndex].voteCount += 1;
        hasVoted[msg.sender] = true;
    }
    function getTotalCandidates() public view returns (uint) {
        return candidates.length;
    }

    function getCandidate(uint index) public view returns (string memory, uint) {
        require(index < candidates.length, "Invalid Index");
        return (candidates[index].name, candidates[index].voteCount);
    }
}
