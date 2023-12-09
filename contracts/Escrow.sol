// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/interfaces/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract Escrow is Ownable {

    using SafeERC20 for IERC20;        
    
    mapping (address => bool) public whitelistedBettingContract;
    mapping(address => uint256) public escrowBalance;

    event AmountDeposited(address indexed p2p, uint256 amount);
    event Withdraw(address indexed p2p, uint256 amount, address indexed user);

    modifier onlyP2PBettingContract() {
        require(whitelistedBettingContract[msg.sender], "Only P2PBetting contract can call this function");
        _;
    }

    constructor() {
    }

    function whiteListP2PBettingContract(address _p2p) external onlyOwner {
        whitelistedBettingContract[_p2p] = true;
    }

    function deposit(address token, uint256 amount) external onlyP2PBettingContract {
        escrowBalance[msg.sender] += amount;
        IERC20(token).safeTransferFrom(tx.origin, address(this), amount);
        emit AmountDeposited(msg.sender, amount);
    }

    function depositEth(uint256 amount) external payable onlyP2PBettingContract {
        escrowBalance[msg.sender] += amount;
        emit AmountDeposited(msg.sender, amount);
    }
   
    function withdraw(address token, uint256 amount, address user) external onlyP2PBettingContract {
        uint remainingAmount = escrowBalance[msg.sender];   
        require(remainingAmount >= amount, "transfer amount low");
        escrowBalance[msg.sender] -= amount;
        IERC20(token).safeTransfer(user, amount);
        emit Withdraw(msg.sender, amount, user);
    }

    function withdrawEth(uint256 amount, address user) external onlyP2PBettingContract {
        uint remainingAmount = escrowBalance[msg.sender];   
        require(remainingAmount >= amount, "transfer amount low");
        (bool success, ) = user.call{value: amount}("");
        require(success, "Failed to send Ether");
        emit Withdraw(msg.sender, amount, user);
    }
}
