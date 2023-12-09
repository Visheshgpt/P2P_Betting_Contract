// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./P2PBetting.sol";

contract Factory is Ownable {

    uint public bettingIdCounter;
    address public immutable escrowContract;
    mapping (address => bool) public isTokenallowed;
    mapping (uint => address) public bettingAddress; 
     
    event NewP2PBetting(uint indexed bettingId, address indexed bettingAddress);
      
    constructor (address[] memory tokens, address _escrowContract) {
        escrowContract = _escrowContract;
        for (uint i=0; i < tokens.length; i++) {
            isTokenallowed[tokens[i]] =true;
        }
        isTokenallowed[address(0)] =true; // for eth
    }

    function createNewBetting(string calldata title, string[] calldata bettingOptions, uint startTime, uint endTime, address admin, address token) external onlyOwner returns (address newbettingAddress) {
        require(isTokenallowed[token], "token not whitelisted");
        require(startTime > block.timestamp && endTime > startTime, "invalid time");
        bettingIdCounter +=1;
        P2PBetting newbetting = new P2PBetting(admin, title, bettingOptions, token, startTime, endTime);
        newbetting.setEscrowContract(escrowContract);
        newbettingAddress = address(newbetting); 
        bettingAddress[bettingIdCounter] = newbettingAddress;

        emit NewP2PBetting(bettingIdCounter, newbettingAddress); 
    }

    function addNewToken(address _newToken) external onlyOwner {
        require(!isTokenallowed[_newToken], "already added");
        isTokenallowed[_newToken] = true;
    }

}   

