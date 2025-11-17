//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
contract Betting{
    struct Candidate{
        string Candidate_name;
        address Candidate_address;
        uint id;
        uint votes_recieved;
    }
    bool registration_open = false;
    bool registration_close = false;
    struct Voter{
        address Voter;
        uint voter_no;
        uint Voted;
    }
    address public owner;
    modifier onlyOwner{
        require(msg.sender == owner, "Not contract owner");
        _;
    }
    bool voting_start = false;
    bool voting_end = false;
    bool results_out = false;
    uint total_candidates = 0;
    uint total_voters = 0;
    Candidate[] public Candidates;
    constructor(){
        owner = msg.sender;
    }
    Voter[] public Voters;
    function voter_list(address _Voter,uint voter_no) public{
        require(voting_start==false, "You can't register after voting has started.");
        Voters.push(Voter(_Voter, voter_no, 0));
    }
    function candidate_registration(string memory Candidate_name,uint id, address _Candidate_address) public {
        require(voting_start==false, "Voting is already open.");
        Candidates.push(Candidate(Candidate_name, _Candidate_address, id, 0));
        total_candidates++;
    }
    function start_voting() public onlyOwner{
        require(voting_start==false, "Voting already started.");
        voting_start=true;
    }
    function vote(uint id, uint Voted) public{
        require(voting_start==true, "Voting not started yet.");
        require(id>=1, "Please enter valid id.");
        require(id<=Candidates.length, "Please enter valid id.");
        require(Voted==0, "You have voted already.");
        Candidates[id-1].votes_recieved++;
        Voted = 1;
    }
    function view_vote_count(uint id)view public returns(uint){
        require(id>=1, "Please enter valid id.");
        require(id<=Candidates.length, "Please enter valid id.");
        return (Candidates[id-1].votes_recieved);
    }
    function ending_voting() public onlyOwner{
        voting_end = true;
    }
    function find_winner() public view returns (string memory winner, uint winner_votes_recieved, address winner_address){
        require(voting_end==true, "Voting not ended yet.");
        require(Candidates.length >= 1, "No candidates were registered.");
        uint max_votes = 0;
        uint winner_id = 0;
        for (uint i = 0; i<Candidates.length; ++i) {
            if(Candidates[i].votes_recieved > max_votes){
                max_votes = Candidates[i].votes_recieved;
                winner_id = i;
            }
        }
        return (Candidates[winner_id].Candidate_name, max_votes, Candidates[winner_id].Candidate_address);
    }
}