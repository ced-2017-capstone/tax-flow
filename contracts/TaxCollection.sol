pragma solidity ^0.4.11;

contract TaxCollection{

    address citizen;
    mapping(address => uint) public balances;

    function TaxCollection(uint _amount) {
         citizen = msg.sender;
         balances[citizen] = _amount;
    }
}

    function payDepartment(){
        
    } 
   
}
