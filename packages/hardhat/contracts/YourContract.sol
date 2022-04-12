pragma solidity ^0.8.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";
import "./PayableContract.sol";

contract YourContract is Payable {
    // EVENTS

    // STORAGE, MAPPINGS, STRUCTS
    uint256 public recordID = 0;
    uint256 public thisRecordID = 0;
    mapping(uint256 => mapping(address => Records)) records;
    mapping (address => bool) public isPatient;
    mapping (address => bool) public isHospital;
    //mapping (address => Records) records;

    struct Records {
        address patient;
        address hospital;
        uint256 admissionDate;
        uint256 dischargeDate;
        uint256 visitReason;
        uint256 thisRecordID;
    }

    Records[] recordsarray;
    Records[] getstructs;

    modifier onlyHospital(uint256 recordID, address _patientAddress) {
      require(records[recordID][_patientAddress].hospital == msg.sender);
      _;
    }

    // FUNCTIONS
    constructor() {
        addRecord(
            0x3719dB98b075Ff10886Fc29431Ffc2006fFF0005,
            0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266,
            20220320,
            20220330,
            1
        );
        addRecord(
            0x3719dB98b075Ff10886Fc29431Ffc2006fFF0005,
            0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266,
            20220333,
            20220333,
            2
        );
        addRecord(
            0x60814DB6b62fE178d7F91239078e3c20fB857E04,
            0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266,
            20220310,
            20220311,
            3
        );
        addHospital(
          0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
          );
    }

    function addHospital(address _hospital) public onlyOwner{
        isHospital[_hospital] = true;
    }

    function addRecord(
        address _patientAddress,
        address _hospital,
        uint256 _admissionDate,
        uint256 _dischargeDate,
        uint256 _visitReason
    ) public {
        //records[recordCount][_patientAddress].providedName = _name;
        records[recordID][_patientAddress].patient = _patientAddress;
        records[recordID][_patientAddress].hospital = _hospital;
        records[recordID][_patientAddress].admissionDate = _admissionDate;
        records[recordID][_patientAddress].dischargeDate = _dischargeDate;
        records[recordID][_patientAddress].visitReason = _visitReason;
        records[recordID][_patientAddress].thisRecordID = thisRecordID;

        recordsarray.push(
            Records(
                _patientAddress,
                _hospital,
                _admissionDate,
                _dischargeDate,
                _visitReason,
                thisRecordID
            )
        );
        recordID++;
        thisRecordID++;
    }

    function getmappingStruct(address _patientAddress, uint256 _recordID)
        public
        view
        returns (Records memory)
    {
        return records[_recordID][_patientAddress];
    }

    function getRecordByAddressStruct(address _patientAddress)
        public
        returns (Records[] memory)
    {
        Records[] storage _getstructs = getstructs;
        for (uint256 i = 0; i < _getstructs.length; i++) {
            if (_patientAddress == recordsarray[i].patient == true) {
                Records memory newRecord = Records({
                    patient: recordsarray[i].patient,
                    hospital: recordsarray[i].hospital,
                    admissionDate: recordsarray[i].admissionDate,
                    dischargeDate: recordsarray[i].dischargeDate,
                    visitReason: recordsarray[i].visitReason,
                    thisRecordID: recordsarray[i].visitReason
                });
                _getstructs.push(newRecord);
            } else {
                continue;
            }
        }
        return _getstructs;
    }

    function getRecordByAddressMap(address _patientAddress)
        public
        view
        returns (Records[] memory)
    {
        Records[] memory rec = new Records[](recordID);
        for (uint256 i = 0; i <= rec.length; i++) {
            if (
                _patientAddress == records[i][_patientAddress].patient == true
            ) {
                rec[i] = records[i][_patientAddress];
            } else {
                continue;
            }
        }
        return rec;
    }

    function deleteRecord(address _patientAddress, uint256 _recordID) public onlyOwner {
        delete records[_recordID][_patientAddress];
    }
}
