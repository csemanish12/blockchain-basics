// SPDX-License-Identifier: MIT


pragma solidity ^0.8.8;

import "./PriceConverter.sol";

contract FundMe {

    using PriceConverter for uint256;

    uint256 public minimumUsd = 5 * 1e18;

    address public owner;

    constructor(){
        owner = msg.sender;
    }

    function fund() public payable {
        // want to be able to set a minimum fund amount in USD
        address[] public funders;
        mapping(address => uint256) public addressToAmountFunded;
        
        require (msg.value.getConversionRate() >= minimumUsd, "Didn't send enough"); // 1e18 == 1 * 10 ** 18
        // require keyword is a checker which reverts if false
        // reverting: undo any action before, and send remaining gas back 
        funders.push(msg.sender)
        addressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw() public onlyOwner{
        for(uint256 funderIndex=0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }

        funders = new address[](0);

        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call Failed");

    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

}