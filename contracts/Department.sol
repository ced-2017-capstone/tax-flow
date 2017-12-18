/*
Author: Benjamin M. Brown
Email: benjaminbb@gmail.com
Git: benjaminmbrown
*/
pragma solidity ^0.4.11;

contract Department { 

    function Department () payable { 
        owner = msg.sender;
    }
    
    address public owner;
    uint public balance;
    
    struct Supplier {
        address addr;
        mapping(address => uint) invoices;
    }

    struct Invoice {
        address invoiceAddress;
    }
    
    mapping(address => uint) public registeredSuppliers;
    mapping(address => uint) public registeredInvoices;

    //*** Modifiers ***/

    //Modifier to check for owner approval
    modifier onlyBy(address _account) {
        require(msg.sender == _account);
        _;
    }
    //Modifier checks that the supplier is in approved supplier list
    modifier byApprovedSupplier(address _supplier){
        require(registeredSuppliers[_supplier]>0);
        _;
    }

    //*** Events ***/
    event OwnerChanged(address indexed _owner, address indexed _newOwner);
    

    //*** Contract Functions ***/
    //Allows changing of ownership
    function changeOwner(address _newOwner) onlyBy(owner){
        OwnerChanged(owner, _newOwner);
        owner = _newOwner;
    }
 
    //Only contract owner can approve a new supplier
    //approved suppliers can invoice this deparment
    function registerSupplier(address _supplier) onlyBy(owner) {
       require (registeredSuppliers[_supplier] == 0);
       registeredSuppliers[_supplier] = 1; 
       
    }
    //Removes a supplier. Invoices are retained
    function deregisterSupplier(address _supplier) onlyBy(owner){
        require(registeredSuppliers[_supplier] == 1);
        registeredSuppliers[_supplier] = 0;
    }
    
    //sets and invoice address
    function registerInvoice(address _addr) public onlyBy(owner) returns (bool success){
        require(registeredInvoices[_addr] == 0);
        registeredInvoices[_addr] = 1;
        return true;
    }
    
    function removeInvoice(address _invoice) public onlyBy(owner) returns (bool success) {
        require(registeredInvoices[_invoice] == 1);
        registeredInvoices[_invoice] = 0;
        return true;
    }
    
    //The owner can pay a registered invoice
    function payInvoice(address _invoiceAddr) onlyBy(owner){
        require(registeredInvoices[_invoiceAddr]==1);
        balance -= msg.value;
        _invoiceAddr.transfer(msg.value);
	}

    
    // receives payment from tax distribution and pays out 
    // between active invoices
    function receiveDeposit () 
    public 
    payable 
    returns (bool success){
        balance += msg.value; 
        return true;
    }
    
    //fallback
    function () payable {}
}
