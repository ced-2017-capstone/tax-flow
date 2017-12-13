pragma solidity ^0.4.11;

contract Department { 
    
      function Department () { 
        owner = msg.sender; 
        balance = 0;
    }
    
    address public owner;
    uint public balance;
    
    mapping(address => uint) approvedSuppliers;
    
    //Modifier to check for owner approval
    modifier onlyBy(address _account) {
        require(msg.sender == _account);
        _;
    }
    
    //Allows changing of ownership
    function changeOwner(address _newOwner) onlyBy(owner){
        owner = _newOwner;
    }
 
    function addSupplier(address supplier) onlyBy(owner) {
       if(approvedSuppliers[supplier]==0){
          approvedSuppliers[supplier] = 1; 
       }
    }
    
    
    function receivePayment (uint payment) public payable {
        balance += payment;
    }

    //****** FUNCTIONS ******/

    function getBalance() public constant returns(uint _balance){
        return balance;
    } 
    
      function getSuppliers() public constant returns(address[] approvedSuppliers){
        return approvedSuppliers;
    } 

}
