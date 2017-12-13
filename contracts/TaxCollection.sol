pragma solidity ^0.4.11;

contract TaxCollection{

    address public dept1 = 0xE0f5206BBD039e7b0592d8918820024e2a7437b9;
    uint deptSplit = 30;
    uint departmentSplit;
    address sender;
    uint amount;
    event sendSplit (address dept1, uint Split);

    mapping(address => uint) public departmentAmount;

    function TaxCollection() {
        sender = msg.sender;
    }

    function payDepartment() return (uint) {
        amount=msg.value;
        departmentSplit= (amount*deptSplit)/100;
        return (departmentSplit)
    }
}
