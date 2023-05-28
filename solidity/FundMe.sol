// SPDX-License-Identifier: MIT


pragma solidity ^0.8.8;

import "./PriceConverter.sol"; 

contract FundMe {
    using PriceConverter for uint256;

    uint256 public constant MINIMUM_USD = 5 * 1e18;

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    address public immutable i_owner;
    
    constructor(){
        i_owner = msg.sender;
    }

    function fund() public payable {
        // want to be able to set a minimum fund amount in USD
        
        require (msg.value.getConversionRate() >= MINIMUM_USD, "Didn't send enough"); // 1e18 == 1 * 10 ** 18
        // require keyword is a checker which reverts if false
        // reverting: undo any action before, and send remaining gas back 
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;

    }

    function withdraw() public onlyOwner {
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }

        funders = new address[](0);
        // reset an array

        // // three different ways to send 

        // // first option transfer (simplest way)
        // payable(msg.sender).transfer(address(this).balance);
        // // msg.sender = address
        // // payable(msg.sender) = payable address

        // // send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send Failed");

        // call (recommended way to send or receive )
        // returns two variables bool callSuccess, bytes memory dateReturned
        (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call Failed");
    }

    modifier onlyOwner {
        require(msg.sender == i_owner, "Sender is not owner!");
        _;
    }

}