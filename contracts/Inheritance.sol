// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Multiplayer{

    mapping(address => bool) public players ;

    function joinGame() public virtual {
        players[msg.sender] =  true;
    }
}

contract Game is Multiplayer{

    string public gameName;
    uint256 public playerCount;

    constructor (string memory _gameName){
        gameName = _gameName;
        playerCount = 0;
    }
    
    function startGame() public{
        //game logic
    }

    function joinGame() public override {
        super.joinGame();
        playerCount++;
    }
}