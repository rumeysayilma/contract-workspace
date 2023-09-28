// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

contract SimpleContract {
    bool public allowed;
    uint public count;
    int public signedCount;
    //string private errorMessage = "is not Allowed";
    //mapping(address => bool) public allowance; //mapping icinde erisilmek istenen adres buraya gonderilir. karsılıgında bool 1/0 dönülür
    
    mapping(address => mapping(address => bool) ) public allowance;

    //error mesaj listesi olusturalım:
    string[2] public errorMessages;  //fixed size array
    //string[] public errorMessages;  //unfixed size
    address public owner; //hangi adres bu contract ın sahibi olacak

    //constructor tanımlamamız lazım:
    constructor(address _address){
        owner=_address;
        errorMessages[0] = "is not allowed";
        errorMessages[1] = "only owner";
        //errorMessages.push("is not allowed"); 
        //errorMessages.push("only owner"); 

    }

    function setAllowed(bool _owner) public {
        allowed = _owner;
    }
    modifier isAllowed() {
        require(allowance[owner][msg.sender],errorMessages[0]);
        _;
    }

    modifier OnlyOwner(){
        require(owner == msg.sender, errorMessages[1] );
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
        allowance[owner][_address] = true; //belli bir adrese yetki tanimladim

    }
    function getSizeOfErrorMessages() public view returns(uint){

        return errorMessages.length;
    }

}