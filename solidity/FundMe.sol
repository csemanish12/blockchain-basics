// Get funds from users
// Withdraw funds
// set a minimum funding value in usd

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract FundMe {

    function fund() public payable {
        require(msg.value > 1e18, "Didn't send enought");
    }

}