// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

contract SimpleContract {
    bool public allowed;
    uint public count;
    int public signedCount;
    string private errorMessage = "is not Allowed";
    mapping(address => bool) public allowance; //mapping icinde erisilmek istenen adres buraya gonderilir. karsılıgında bool 1/0 dönülür
    
    address public owner; //hangi adres bu contract ın sahibi olacak

    //constructor tanımlamamız lazım:
    constructor(){
        owner=address(0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2);
    }

    function setAllowed(bool _allowed) public {
        allowed = _allowed;
    }
    modifier isAllowed() {
        require(allowance[msg.sender],errorMessage);
        _;
    }

    modifier OnlyOwner(){
        require(owner == msg.sender, "only owner" );
        _;
    }

    function buy() isAllowed public  {

    }

    function oneIncrement() public {
        ++count;
    }

    function increment(uint _increment) isAllowed public{
        count = count + _increment;
    }

    function signedIncrement(int _increment) public {
        signedCount = signedCount + _increment;
    }

    function assignAllowence(address _address) public OnlyOwner{ 
        allowance[_address] = true; //belli bir adrese yetki tanimladim

    }


}