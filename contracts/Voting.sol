// SPDX-License-Identifier: MIT
pragma solidity >=0.4.0 <0.9.0;

contract Election {
    enum State {
        NotStarted,
        InProgress,
        Ended
    }

    struct Candidate {
        uint256 id;
        string name;
        uint256 voteCount;
    }

    address public owner;
    State public electionState;

    struct Voter {
        uint256 id;
        string name;
    }

    mapping(uint256 => Candidate) candidates;
    mapping(address => bool) voted;

    mapping(address => bool) isVoter;

    uint256 public candidatesCount = 0;

    uint256 public votersCount = 0;

    uint256[] winningCandidateIds;


    constructor() {
        owner = msg.sender;
        electionState = State.NotStarted;
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
    }

    event Voted(uint256 indexed _candidateId);
    event Log(string message);
    event ElectionEnded(string winnerName, uint256 voteCount);




    function startElection() public {
        emit Log("election has started");
        require(msg.sender == owner);
        require(electionState == State.NotStarted);
        electionState = State.InProgress;
    }

    function endElection() public {
        emit Log("election has ended");
        require(msg.sender == owner);
        require(electionState == State.InProgress);
        electionState = State.Ended;

       // Find the winner or handle ties
        uint256 winningVoteCount = 0;
        //list of winning candidates to handle tie alike situation
    
        for (uint256 i = 0; i < candidatesCount; i++) {
            if (candidates[i].voteCount > winningVoteCount) {
                winningVoteCount = candidates[i].voteCount;
                delete winningCandidateIds; // Clear previous winners
                //winningCandidateIds = new uint256 ; // Reinitialize the array
                winningCandidateIds[0] = i;
            } else if (candidates[i].voteCount == winningVoteCount) {
                winningCandidateIds.push(i);
        }
    }

    //Handle Ties in the elections feature
    // If there is a tie
    if (winningCandidateIds.length > 1) {
        //  select one winner randomly from the tied candidates list
        uint256 randomIndex = uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty))) % winningCandidateIds.length;
        winningCandidateIds = [winningCandidateIds[randomIndex]];
    }

    //Declare winner feature
    // Emit the event for the single winner
    emit Log(string(abi.encodePacked("winner is ", candidates[winningCandidateIds[0]].name)));
    emit ElectionEnded(candidates[winningCandidateIds[0]].name, winningVoteCount);

    }

    //Add Candidates feature
    function addCandidate(string memory _name) public {
        require(owner == msg.sender, "Only owner can add candidates");
        require(
            electionState == State.NotStarted,
            "Election has already started"
        );

        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
        candidatesCount++;
    }
    //Add voters feature

    function addVoter(address _voter) public {
        require(owner == msg.sender, "Only owner can add voter");
        require(!isVoter[_voter], "Voter already added");
        require(
            electionState == State.NotStarted,
            "Voter can't be added after election started"
        );

        isVoter[_voter] = true;
    }

    //get Roles feature
    function getRole(address _current) public view returns (uint256) {
        if (owner == _current) {
            return 1;
        } else if (isVoter[_current]) {
            return 2;
        } else {
            return 3;
        }
    }

    function vote(uint256 _candidateId) public {
        require(
            electionState == State.InProgress,
            "Election is not in progress"
        );
        require(isVoter[msg.sender], "Non authorised user cannot vote");
        require(!voted[msg.sender], "You have already voted");
        require(
            _candidateId >= 0 && _candidateId < candidatesCount,
            "Invalid candidate ID"
        );

        candidates[_candidateId].voteCount++;
        voted[msg.sender] = true;

        emit Voted(_candidateId);
    }

    function getCandidateDetails(uint256 _candidateId)
        public
        view
        returns (string memory, uint256)
    {
        require(
            _candidateId >= 0 && _candidateId < candidatesCount,
            "Invalid candidate ID"
        );
        return (
            candidates[_candidateId].name,
            candidates[_candidateId].voteCount
        );
    }
}
