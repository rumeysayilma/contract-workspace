// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

contract SimpleContract {
    bool public allowed;
    uint public count;
    int public signedCount;
    string private errorMessage = unicode"bu özellik aktif değil";

    function setAllowed(bool _allowed) public {
        allowed = _allowed;
    }
    modifier isAllowed() {
        require(allowed,errorMessage);
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


}