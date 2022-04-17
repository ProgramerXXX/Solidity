//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; 
import 'github.com/OpenZeppelin/openzeppelin-contracts/contracts/utils/math/SafeMath.sol';

contract Banks{

    using SafeMath for uint;
    uint _balance;
    
    function deposit(uint amount) public {
            _balance = _balance.add(amount); 
    } 
    function withdraw(uint amount) public {
            _balance = _balance.sub(amount);
    }
    function balance() public view returns(uint balance_) {
            return _balance;
    }
    
    

}