// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract Payable is Ownable {
    // Function to deposit Ether into this contract.
    // Call this function along with some Ether.
    // The balance of this contract will be automatically updated.
    function deposit() public payable {}
/*
    function withdraw() public onlyOwner {
        address payable _owner = payable(address(owner()));
        _owner.transfer(address(this).balance);
    }
    */

    // Function to transfer Ether from this contract to address from input
    function transfer(address payable _to, uint _amount) public onlyOwner {
        // Note that "to" is declared as payable
        (bool success, ) = _to.call{value: _amount}("");
        require(success, "Failed to send Ether");
    }
}