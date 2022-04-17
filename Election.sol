//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

struct Issue{
    bool open;
    mapping(address => bool) voted;
    mapping(address => uint) ballots;
    uint[] scores;
}

contract Election{
    address _admin;
    mapping(uint => Issue) _issue;
    uint _issueID;
    uint _min;
    uint _max;
    event StatusChange(uint indexed issueID, bool open);
    event Vote(uint indexed issueID , address voter , uint indexed option);

    constructor(uint min , uint max){
        _admin = msg.sender;
        _min = min;
        _max = max;
    }

    modifier onlyAdmin {
        require(msg.sender == _admin,"unauthorized");
        _;
    }

    function open() public onlyAdmin {
        require(!_issue[_issueID].open,"Election Opening");
        _issueID++;
        _issue[_issueID].open = true;
        _issue[_issueID].scores = new uint[](_max+1);
        emit StatusChange(_issueID, true);
    }

    function close() public onlyAdmin{
        require(_issue[_issueID].open, "election colsed");
        _issue[_issueID].open = false;
        emit StatusChange(_issueID, false);
    }

    function vote(uint option) public {
        require(_issue[_issueID].open , "election closed");
        require(!_issue[_issueID].voted[msg.sender]," you are voted");
        require(option >= _min && option <= _max,"incorrect option");
        _issue[_issueID].scores[option]++;
        _issue[_issueID].voted[msg.sender] = true;  
        _issue[_issueID].ballots[msg.sender] = option;
        emit Vote(_issueID, msg.sender , option);
   }

   function status() public view returns(bool open_){
       return _issue[_issueID].open;
   }

   function ballot() public view returns(uint){
       require(_issue[_issueID].voted[msg.sender],"you are not vote");
       return _issue[_issueID].ballots[msg.sender];
   }

    function scores() public view returns(uint[] memory){
        return _issue[_issueID].scores;
    }
}