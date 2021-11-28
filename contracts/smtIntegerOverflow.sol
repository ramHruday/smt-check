// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
pragma experimental SMTChecker;

contract Overflow {
    uint256 private sellerBalance = 0;

    function add(uint256 value) public returns (bool) {
        sellerBalance += value; // possible overflow

        // possible auditor assert
        // assert(sellerBalance >= value);
    }

    function safe_add(uint256 value) public returns (bool) {
        require(value + sellerBalance >= sellerBalance);
        sellerBalance += value;
    }
}
