// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DeadMansSwitch {
    address public owner;
    address public beneficiary;
    uint256 public lastAliveBlock;

    // Constructor to set the owner and beneficiary
    constructor(address _beneficiary) {
        owner = msg.sender;
        beneficiary = _beneficiary;
        lastAliveBlock = block.number;
    }

    // Function to mark the owner as still alive
    function still_alive() public {
        require(msg.sender == owner, "Only the owner can call this function.");
        lastAliveBlock = block.number;
    }

    // Function to trigger the deadman's switch
    function trigger() public {
        require(block.number > lastAliveBlock + 10, "Owner is still active.");
        selfdestruct(payable(beneficiary));
    }

    // Fallback function to receive Ether
    receive() external payable {}

    // Function to get the contract balance
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
