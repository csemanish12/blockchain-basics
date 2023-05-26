// Get funds from users
// Withdraw funds
// set a minimum funding value in usd

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe {

    function fund() public payable {
        require(msg.value > 1e18, "Didn't send enought");
    }

    function getVersion() public view returns (uint256){
        // Address: 0x694AA1769357215DE4FAC081bf1f309aDC325306
        // ABI : 
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        return priceFeed.version();
    }

}