pragma solidity ^0.4.11;

contract Department { 
    
    function Department () { 
        owner = msg.sender; 
        balance = 0;
    }
    
    address public owner;
    uint public balance;
    
    mapping(address => uint) public approvedSuppliers;
    mapping(address => uint) public approvedInvoices;
    mapping(address => uint) public outstandingInvoices
    
    //Modifier to check for owner approval
    modifier onlyBy(address _account) {
        require(msg.sender == _account);
        _;
    }
    
    modifier byApprovedSupplier(address _supplier){
        require(approvedSuppliers[_supplier]>0);
        _;
    }
    
    //Allows changing of ownership
    function changeOwner(address _newOwner) onlyBy(owner){
        owner = _newOwner;
    }
 
    //Only contract owner can approve a new supplier
    //approved suppliers can invoice this deparment
    function approvedSupplier(address supplier) onlyBy(owner) {
       require (approvedSuppliers[supplier] == 0);
       approvedSuppliers[supplier] = 1; 
       
    }
    //Removes a supplier. Invoices are retained
    function removeSupplier(address supplier) onlyBy(owner){
        require(approvedSuppliers[supplier] == 1);
        approvedSuppliers[supplier] = 0;
    }
    
    function addInvoice(address _invoice ) public returns (bool success){
        require(approvedInvoices[_invoice] == 0  && 
        approvedSuppliers[_invoice.sender] > 0);
        
        approvedInvoices[_invoice] = 1;
        return true;
        
    }
    function payInvoice(address _invoiceAddr) onlyBy(owner){
        //send $ to '
    }
    
    // receives payment from tax distribution and pays out 
    // between active invoices
    function deposit () 
    public 
    payable 
    returns (bool success){
        balance += msg.value; 
        return true;
    }
    
    //fallback
    function () payable {}
}
