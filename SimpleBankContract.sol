// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

//contract is like a class
contract SimpleBank {
    //Mapping address to bank
    mapping(address => uint256) private balances;

    //Event that is emitted when a dposit is made
    event Deposited(address indexed user,uint256);

    //Event that is emitted when a withdrawl is made
    event Withdrawn(address indexed user,uint256 amount);

    //Function to deposit ether into the bank;
    function deposit() public payable {
        require(msg.value > 0,"Deposit amount must be greater than zero.");
        balances[msg.sender] += msg.value;
        emit Deposited(msg.sender, msg.value);
    }

    function withdraw(uint256 amount) public {
        require(amount <= balances[msg.sender],"Insufficient balance.");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdrawn(msg.sender, amount);

    }

    //Function to check balance of the calleer
    function getBalance() public view returns(uint256){
        return balances[msg.sender];
    }

}
