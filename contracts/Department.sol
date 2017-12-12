pragma solidity ^0.4.11;
// ---Department Overview / Notes---
// Accepts funding payments from distributor
// Registers addresses as authorized suppliers
// Manages outstanding invoice queue
// Sends payment to outstanding invoices
// Public can access balance
// Public can access vendor list
// Event tracking for all actions

contract Department { 
    
    //****** PARAMETERS ******/
    struct Supplier {
        uint approved; // 1 or 0 - see Ballot example
        bool paidInFull;
        address supplier;
        uint payment; 
    }
    

    address public owner;
    uint public balance;

    mapping(address => Supplier) public approvedSuppliers;
    mapping(address => uint) public outstandingInvoices;

    //****** CONSTRUCTOR ******/

    function Department (){
        owner = msg.sender; //whoever creates the contract is the owner
    }

    //****** EVENTS ******/

    event FundsDistributed(uint amount);
    /*
        FundingReceived
        Distributions Made
        ApprovalRequested
        ApprovalGranted
        PaidSupplierInFull
        PaidSupplierPartially
    */

    //****** FUNCTIONS ******/

    // allows contract owner to add a supplier to whitelist
    // only approved suppliers can send invoices

    function approveSupplier(address supplier){
        require(msg.sender == owner && !approvedSuppliers[supplier].approved);
    }

    // Takes a distrubution and pays invoices

    function distribute() payable {
        //TODO: 
    }

    //****** FUNCTIONS ******/
    function getOutstandingInvoices() constant returns () {

    }
    function getApprovedSuppliers() constant returns() {
        //TODO:
    }   

    function getDepartmentBalance() constant returns(){
        //TODO: 
    } 
}
