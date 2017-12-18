//Author: Mohamed Hasan
pragma solidity ^0.4.11;

contract TaxCollection {
    uint balance;
    
    mapping(address => uint) public departmentBalance;
    address[2] public departmentlist;
    
    event LogReceived(address sender,uint amount);
    event Logsent(address beneficiary,uint amount);
    
    //needs to set the initial balance
    function TaxCollection(address dept1,address dept2) public {
        departmentlist[0]=dept1;
        departmentlist[0]=dept2;
        balance=0;
    }
    
    //create a function to receive payment from outside world and increase balanc
        function getPayment() public payable {
        balance += msg.value ;
    }
    
    //payDepartment accept a payment  */
    function payDepartment () public payable returns (bool success) {
    if(balance==0) revert();

    uint split = balance/2;
    departmentBalance[departmentlist[0]] += split;
    departmentBalance[departmentlist[1]] += split;
    LogReceived(msg.sender,msg.value);
    return true;
    }
  
    //Withdraw allows department to request payment
    function withdraw(uint amount) public returns(bool success){
    if (departmentBalance[msg.sender] < amount) revert(); 
    departmentBalance[msg.sender] -= amount;         
    if (!msg.sender.send(amount)) revert();              
    Logsent(msg.sender, amount);
    return true;
    }

}