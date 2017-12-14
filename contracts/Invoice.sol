pragma solidity ^0.4.11;

contract Invoice {

    function Invoice (){
        sender = msg.sender;
        balance = 0;
        pending = 100;
    }
 // balance is 0 until payment arrives

    address public owner;
    uint public balance;

    mapping(address => uint) Department;

    function sendInvoice(address Department) onlyBy(owner){
        sender = msg.sender;
        pending = 100;
    }
 // supplier sends invoice to the Department


}
