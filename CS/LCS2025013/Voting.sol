//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Voting{
    struct Candidate{
        string name;
        uint votes;
    }

    Candidate[2] public candidates;

    mapping(address=>bool) public voters;

    address public owner;
    constructor(string memory cand1, string memory cand2){
        owner=msg.sender;
        candidates[0]=Candidate(cand1,0);
        candidates[1]=Candidate(cand2,0);
    }

    modifier onlyOwner(){
        require(owner==msg.sender,"Not the owner");
        _;
    }

    bool public voting_begun=false;
    bool public voting_ended=false;
    function voting_status_1() public onlyOwner{
        require(voting_begun==false,"Voting has already begun");
        voting_begun=true;
    }

    function voting_process(uint _index, address _addr) public{
        require(voting_begun==true,"Voting hasn't started");
        require(voting_ended==false,"Voting has ended");
        require(_index==0||_index==1,"Invalid Candidate");
        require(voters[_addr]==false,"Has already voted");
        voters[_addr]=true;
        candidates[_index].votes++;
    }
    
    function voting_status_2() public onlyOwner{
        require(voting_ended==false,"Voting has already ended");
        voting_ended=true;
    }

    function winner_declaration() public view returns(string memory){
        if(candidates[0].votes>candidates[1].votes){
            return candidates[0].name;
        }
        else if(candidates[0].votes<candidates[1].votes){
            return candidates[1].name;
        }
        else{
            return "Tie!!";
        }
    }
}