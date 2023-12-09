// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/interfaces/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

interface IEscrow {

    function deposit(address token, uint256 amount) external;
    function depositEth(uint256 amount) external payable;
    function withdraw(address token, uint256 amount, address user) external;
    function withdrawEth(uint256 amount, address user) external;
    
}
    
contract P2PBetting {

    using SafeERC20 for IERC20;         

    struct Betting {
        string title;
        uint totalOptions;
        uint totalBetsRecived;
        mapping (uint => string) bettingOptions;
        mapping (uint => uint) betReceivedPerOptions;
        uint bettingStartTime;
        uint bettingEndTime;
        uint optionWinner;
        bool isWinnerDeclared;
        mapping (address => User) userInfo; 
        address token;  // if add =0, native
        address admin;
    }
     
    struct User {
        uint betOption;
        uint stakeAmount;
        bool hasBet;
        bool hasClaimed;
    }

    address public immutable factory;
    Betting public betting;
    IEscrow public escrowContract;

    event Participate(address indexed user, uint indexed amount, uint indexed option);
    event WinnerDeclare(uint option);

    modifier onlyAdmin() {
        require(msg.sender == betting.admin, "Unauthorized");
        _;
    }

    modifier onlyAdminOrFactory() {
        require(msg.sender == betting.admin || msg.sender == factory, "Unauthorized");
        _;
    }

    constructor(address admin, string memory title, string[] memory bettingOptions, address token, uint startTime, uint endTime) {
        betting.title =title;
        uint _totalOptions = bettingOptions.length;
        betting.totalOptions = _totalOptions;
        betting.admin = admin;
        betting.token = token;
        betting.bettingStartTime = startTime;
        betting.bettingEndTime = endTime; 
        factory = msg.sender;

        for (uint i =0; i<_totalOptions; i++) {
            betting.bettingOptions[i+1] = bettingOptions[i];      
        } 
    }

    function setEscrowContract(address _escrowContract) external onlyAdminOrFactory {
        escrowContract = IEscrow(_escrowContract);
    }

    function participate(uint option, uint amount) external payable {
        require(option > 0 && option <= betting.totalOptions, "invalid Option");
        require(amount > 0, "zero amount");
        require(betting.bettingStartTime < block.timestamp && betting.bettingEndTime > block.timestamp, "Betting over");
        bool isEth = betting.token == address(0) ? true : false;
         
        betting.betReceivedPerOptions[option] += amount; 
        betting.totalBetsRecived += amount;
        User storage userInfo = betting.userInfo[msg.sender];
        require(!(userInfo.hasBet), "already participate"); 
        userInfo.betOption = option;
        userInfo.stakeAmount = amount;
        userInfo.hasBet = true;

        if (isEth) {
            require(msg.value == amount, "invalid amount");  
            escrowContract.depositEth{value: msg.value}(amount);  
        }   
        else {
            escrowContract.deposit(betting.token, amount);
        } 

        emit Participate(msg.sender, amount, option);
    }

    function declareWinner(uint option) external onlyAdmin {
        require(option > 0 && option <= betting.totalOptions, "invalid Option");
        require(betting.bettingEndTime < block.timestamp, "Betting still live");  
        require(!(betting.isWinnerDeclared), "winner already declared");  
        betting.isWinnerDeclared = true;
        betting.optionWinner = option;

        emit WinnerDeclare(option);
    }    

    function claim() external {
        require(betting.isWinnerDeclared, "winner not already declared yet");
        User storage userInfo = betting.userInfo[msg.sender];
        require(!userInfo.hasClaimed, "already claimed");
        userInfo.hasClaimed = true; 
                   
        uint reward = getUserReward(msg.sender);
        if (reward == 0) {
            revert("No reward to claim");
        }

        bool isEth = betting.token == address(0) ? true : false;

        if (isEth) {
            escrowContract.withdrawEth(reward, msg.sender);
        }   
        else {
            escrowContract.withdraw(betting.token, reward, msg.sender);
        }  
    }

    function getUserInfo(address _user) public view returns (User memory) {
        User memory userInfo = betting.userInfo[_user];
        return userInfo;
    }

    function getUserReward(address _user) public view returns(uint) {
        User memory userInfo = getUserInfo(_user);
        uint amount = userInfo.stakeAmount;
        uint userOption = userInfo.betOption; 
        if (betting.isWinnerDeclared && amount > 0 && userOption == betting.optionWinner) {
          uint winningOption = betting.optionWinner;       
          uint totalBetsRecived = betting.totalBetsRecived;
          uint winningOptionTotalBetsReceived = betting.betReceivedPerOptions[winningOption];  
          uint reward = (totalBetsRecived * amount) / winningOptionTotalBetsReceived;
          return reward;                
        }
        return 0;
    }

    function hasUserBet(address _user) public view returns (bool) {
        return getUserInfo(_user).hasBet;
    }

    function userStakedAmount(address _user) public view returns (uint) {
        return getUserInfo(_user).stakeAmount;
    }

    function hasUserClaimed(address _user) public view returns (bool) {
        return getUserInfo(_user).hasClaimed;
    }

    function getBettingTime() external view returns(uint,uint) {
        uint startTime = betting.bettingStartTime;
        uint endTime = betting.bettingEndTime;
        return (startTime, endTime);
    }

    function getBettingOptions() external view returns (string[] memory) {
        uint bettingOptions = betting.totalOptions;
        string[] memory options = new string[](bettingOptions);
        for (uint i=0; i<bettingOptions; i++) {
            options[i] = betting.bettingOptions[i+1];
        }
        return options;
    }

    function getBetRecievedPerOptions() external view returns (uint[] memory) {
        uint bettingOptions = betting.totalOptions;
        uint[] memory bets = new uint[](bettingOptions);
        for (uint i=0; i<bettingOptions; i++) {
            bets[i] = betting.betReceivedPerOptions[i+1];
        }
        return bets;
    }

}   
