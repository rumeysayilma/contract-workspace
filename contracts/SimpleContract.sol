// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

contract SimpleContract {
    bool public allowed;
    function setAllowed(bool _allowed) public {
        allowed = _allowed;
    }
    modifier isAllowed() {
        require(allowed,"is not allowed");
        _;
    }

    function buy() public isAllowed {

    }


}