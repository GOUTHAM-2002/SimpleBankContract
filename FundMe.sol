//SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;
//0x694AA1769357215DE4FAC081bf1f309aDC325306

import "./ProceConverter.sol";

contract FundMe {
    using PriceConverter for uint256;
    uint256 public minimumUsd = 50 * 1e18;

    address[] public funders;
    mapping(address => uint256) public adrdessToAmountFunded;

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function fund() public payable {
        require(msg.value.getConversionRate() >=minimumUsd,"Didn't meet the funding requirements");
        funders.push(msg.sender);
        adrdessToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw() public onlyOwner{
        require(msg.sender == owner,"Sender i not owner");
        
        for(uint256 i = 0;i<funders.length;i++){
            adrdessToAmountFunded[funders[i]]=0;
        }
         funders = new address[](0);

        (bool callSucess,) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSucess,"call Failed");
    }


    modifier onlyOwner {
        require(msg.sender == owner,"Sender is not owner");
        _;
        
    }
   
}
