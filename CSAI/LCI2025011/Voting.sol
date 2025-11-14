// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;

import "hardhat/console.sol";

contract voting{
    struct vote{
        address voter;
        bool voted;
        uint candidate_no;
    }
    vote[] public votes;

    struct Candidate{
        address candidate;
        uint total_votes;
        uint candidate_no;
    }
    Candidate[] public candidates;

    uint candidate_id = 1;
    address public owner;
    constructor (){
        owner = msg.sender;
    }
    modifier onlyOwner{
        require(msg.sender == owner, "You are not the owner");
        _;
    }

    function add_candidate() public onlyOwner{
        require(msg.sender == owner, "You're not the owner.");
        candidates.push(Candidate(msg.sender, 0, candidate_id));
        candidate_id++;
    }

    function add_vote(uint _candidate_no) public{
        require(candidates.length >= _candidate_no, "Invalid Candidate No.");
        for(uint i=0; i<votes.length; i++){
            if(!votes[i].voted && msg.sender==votes[i].voter){
                candidates[_candidate_no-1].total_votes += 1;
            }
        }
    }

    function check_votes(uint _candidate_no) view  public{
        require(candidates.length >= _candidate_no, "Invalid Candidate No.");
        console.log("Total votes of", _candidate_no , "is: ", candidates[_candidate_no-1].total_votes);
    }
}