// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10; 


contract PiggyBank {

    address owner; 
    uint target;
    uint endDate;
    uint value = 0;


    // Initialise the contract 
    // Define the objective saving amount and the end date
    constructor(
        uint targetValue, 
        uint closeDate
    ){
        owner = msg.sender;
        target = targetValue;
        endDate = closeDate;

    }


    // Deposit some Eth in the account 
    function deposit() public payable {

        require(endDate > block.timestamp);

        value = value + msg.value;

    }


    // Functions to let user see the value contained, their target and time remaining 
    function viewAccount() public view returns(string memory, uint, string memory, uint, string memory, uint) {

        return ("Value held in account: ", value, "Account target: ", target, "Closing Date: ", endDate);
    
    }


    // Payout function if conditions are met
    // If the value target has been met then payout
    // If the timeframe has run out then payout 
    function payout() public payable {

        require(msg.sender == owner);

        if (block.timestamp >= endDate) {
            selfdestruct(payable(owner));
        }

        if (value >= target) {
            selfdestruct(payable(owner));
        }

    }

}

