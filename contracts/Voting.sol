pragma solidity ^0.4.24;

contract Voting {
    struct Candidate {
      address Address;
      uint voteCount;
    }

    enum Stage {
      INIT,
      START,
      FINISH
    }

    address public owner;
    Candidate[] public candidates;
    address[] public voters;
    Stage public stage;
    uint public totalVoteCount;

    event Notify(string x);
    event winner(address winnerAddress);

    constructor () public {
        owner = msg.sender;
        stage = Stage.INIT;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        if (msg.sender != owner) {
            emit Notify("Only owner can do it");
            return;
        }
        _;
    }

    modifier checkStage(Stage _stage) {
      if (_stage != stage) {
        emit Notify("Current stage is invalid");
        return;
      }
      _;
    }

    function addCandidate(address _candidate) onlyOwner() checkStage(Stage.INIT) {
      require(msg.sender == owner);
      for(uint i = 0; i < candidates.length; i++) {
        if(keccak256(_candidate) == keccak256(candidates[i].Address)) {
          emit Notify("This candidate is existed");
          return;
        }
      }
      candidates.push(Candidate(_candidate, 0));
      emit Notify("Add candidate successfully");
    }

    function startVoting() onlyOwner() checkStage(Stage.INIT) {
      if(candidates.length < 2) {
        emit Notify("Voting only start with at least two candidates");
        return;
      }
      stage = Stage.START;
      emit Notify("Start the election");
    }

    function finishVoting() onlyOwner() checkStage(Stage.START) {
      stage = Stage.FINISH;
      emit Notify("Finish the election");
    }

    function winning() public checkStage(Stage.FINISH) {
      uint winningCount = 0;
      address _winner;
      uint _voteCount;
      address result;
      
      for (uint i = 0; i < candidates.length; i++)
      {
        if (candidates[i].voteCount > winningCount)
          {
            winningCount = candidates[i].voteCount;
            _voteCount = winningCount;
            _winner = candidates[i].Address;
          }
      }

      emit winner(result);
    }

    function getCandidateLength() public constant returns (uint lengthCandidate) {
          lengthCandidate = candidates.length;
    }

    function vote(address _candidate) checkStage(Stage.START) {
      for (uint i = 0; i < voters.length; i++) {
        if (msg.sender == voters[i]) {
          emit Notify("This voters was existed");
          return;
        }
      }
      for(i = 0; i < candidates.length; i++) {
        address tempName = candidates[i].Address;
        if(keccak256(_candidate) == keccak256(tempName)) {
            candidates[i].voteCount++;
            totalVoteCount++;
            break;
        }
      }
      voters.push(msg.sender);
      emit Notify("Vote successfully");
    }
}