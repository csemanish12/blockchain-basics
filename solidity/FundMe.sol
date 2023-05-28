// SPDX-License-Identifier: MIT


pragma solidity ^0.8.8;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe {

    uint256 public minimumUsd = 5 * 1e18;

    function fund() public payable {
        // want to be able to set a minimum fund amount in USD
        address[] public funders;
        mapping(address => uint256) public addressToAmountFunded;
        
        require (msg.value >= minimumUsd, "Didn't send enough"); // 1e18 == 1 * 10 ** 18
        // require keyword is a checker which reverts if false
        // reverting: undo any action before, and send remaining gas back 
        funders.push(msg.sender)
        addressToAmountFunded[msg.sender] = msg.value;
    }

    function getPrice() public view returns (uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int256 price,,,) = priceFeed.latestRoundData();
        // ETH. in terms of USD
        // 3000.00000000.  has 8 decimals
        return uint256(price * 1e10); // to make it to 18 decimals 
    }

    function getVersion() public view returns (uint256){
        // Address: 0x694AA1769357215DE4FAC081bf1f309aDC325306
        // ABI : 
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        return priceFeed.version();
    }

    function getConversionRate(uint256 ethAmount) public view returns (uint256){
        uint256 ethPrice = getPrice();
        uint ethAmountInUsed = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsed;
    }
}