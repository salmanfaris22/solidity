// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.26;

contract PusableToken{
    address public  owner;
    bool public paused;
    mapping(address=>uint)public balance;

    constructor(){
        owner =msg.sender;
        paused=false;
        balance[owner]=1000;
    }

    modifier onlyOwner(){
        require(msg.sender == owner, "YOUR NOT THE OWNER");
        _;
    }
      modifier notPaused(){
        require(paused == false, "THIS OWNER TRASACTIONS IS PUASED");
        _;
    }

    function pasue()public  onlyOwner{
        paused=true;
    }
     function unpasue()public  onlyOwner{
        paused=false;
    }

    function transfer(address to,uint amount)public notPaused {
        require(balance[msg.sender] >= amount,"Inseiicent Balance");
        balance[msg.sender]-=amount;
        balance[to]+=amount;
    }

}