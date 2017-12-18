//Author: Shaan Ray
pragma solidity ^0.4.11;

contract Invoice {

    function Invoice (uint _balanceDue){
        sender = msg.sender;
        balanceDue = _balanceDue;
    }

    modifier onlyBy(address _account) {
        require(msg.sender == _account);
        _;
    }

    uint public balanceDue;
    address public sender;

    // supplier sends invoice to the Department
    function sendInvoice(address _department) onlyBy(sender){
        sender = msg.sender;
        
    }

    // accepts payment of invoice
   function receivePayment() payable returns (bool result) {
    //TODO: not sure how payments are handled but assume that Department will
    //check the balanceDue of this invoice and never send more.
    balanceDue -= msg.value;
    return true;
  }

    //fallback to accept funds sent to wrong function
      function () payable {
            balanceDue -= msg.value;
      }

}
