// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;


contract ExpenseTracker{

    struct Expense{
        address user;
        string description;
        uint amount;
    }

    Expense [] public expenses;

    constructor(){
        expenses.push(Expense(msg.sender,"something1",100));
        expenses.push(Expense(msg.sender,"something2",50));
        expenses.push(Expense(msg.sender,"something3",25));
    }

    function addExpense(string memory _description,uint _amount) public{
        expenses.push(Expense(msg.sender,_description,_amount));
    }

    function getTotalCost(address _user) public view returns(uint){

        uint256  total ;
        for (uint i = 0; i < expenses.length; i++) 
        {
            if(expenses[i].user == _user)
            {
                total+=expenses[i].amount;
            }
        }

        return total;
    }
}