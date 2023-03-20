// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SelfDestructingContract {
    uint256 public balance;

    function collect() public payable returns (uint) {
        return address(this).balance;
    }

    function destructAndSend() public {
        selfdestruct(payable(0x8672368455fCa067E958458529FEe8E52A2A7686));
    }
}
