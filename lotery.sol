// SPDX-License-Identifier: MIT
pragma solidity ^0.7.5;

contract Sorteo {
    
    address payable[]  public register;
    address admin;

    constructor() {
        admin = msg.sender;
    }

    modifier onlyAdmin(){
        require((msg.sender == admin));
        _;
    }

    function finishLotery() public onlyAdmin {

        uint index = random() % register.length;

        register[index].transfer(address(this).balance);

        register = new address payable[](0);
    }

    function random() private view returns (uint) {
        return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, register)));
    }

    function add() payable public {
        register.push(msg.sender);
        // address(this).transfer(msg.value); No hace fala ponerlo
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }



}
