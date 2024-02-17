// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;
import "./IStakeToken.sol";

contract StakingContract {
    // STATE VARIABLES
    address stakeToken;

    uint immutable stakingDuration;

    uint immutable inverseRewardRate;

    
    uint immutable minStake;
    
    uint immutable minDeposit;
    
    uint availableRewardTokens;

    // MAPPINGS
    mapping (address => uint) amountStaked;
    
    mapping (address => uint) walletBalance;
    
    mapping (address => uint) reward;
    
    mapping (address => uint) rewardTimeStamp;

    constructor(address _stakeToken, uint _stakingDuration, uint _inverseRewardRate, uint _minDeposit, uint _minStake) {
        stakeToken = _stakeToken;
    
        stakingDuration = _stakingDuration;
    
        inverseRewardRate = _inverseRewardRate;
    
        minStake = _minStake;
    
        minDeposit = _minDeposit;
    }

    // EVENTS
    event SuccesfulDeposit(address sender, uint depositAmount);
    
    event SuccesfulStake(address sender, uint stakeAmount);
    
    event SuccesfulUnstaking(address sender, uint unstakedAmount);
    
    event RewardClaimed(address sender, uint claimedAmount);
    
    event WithdrawSuccessful(address sender, uint _amountWithdrawn);

    // FUNCTIONS
    function depositToWallet(uint _amount) external{
        require(msg.sender != address(0), "Address zero detected");
    
        require(_amount > 0, "cannot deposit 0 token");
    
        require(_amount >= minDeposit, "Not up to the min deposit");
    
        require(IStakeToken(stakeToken).balanceOf(msg.sender) > _amount, "Not enough token");
    
        require(IStakeToken(stakeToken).transferFrom(msg.sender, address(this), _amount), "Failed Deposit");
    
        walletBalance[msg.sender] = walletBalance[msg.sender] + _amount;
    
        emit SuccesfulDeposit(msg.sender, _amount);
    }

    function setAvailableReward() external  {
        availableRewardTokens = IStakeToken(stakeToken).balanceOf(address(this));
    }

    function stake(uint _amount) external{
        require(msg.sender != address(0), "Address zero detected");
     
        require(_amount > 0, "cannot stake 0 token");
     
        require(_amount >= minStake, "Not up to min Stake");
     
        require(walletBalance[msg.sender] > _amount, "Not enough balance in wallet");
     
        // require(availableRewardTokens >= 1000, "Rewards exhausted");
     
        walletBalance[msg.sender] = walletBalance[msg.sender] - _amount;
     
        amountStaked[msg.sender] = amountStaked[msg.sender] + _amount;
     
        setReward();
     
        rewardTimeStamp[msg.sender] = block.timestamp;
     
        emit SuccesfulStake(msg.sender, _amount);
    }

    function unstake() external{
        require(msg.sender != address(0), "Address zero detected");
     
        require(amountStaked[msg.sender] != 0, "You don't have any stake");
     
        amountStaked[msg.sender] = 0;
     
        reward[msg.sender] = 0;
     
        rewardTimeStamp[msg.sender] = 0;
     
        walletBalance[msg.sender] = walletBalance[msg.sender] + amountStaked[msg.sender];
     
        emit SuccesfulUnstaking(msg.sender, amountStaked[msg.sender]);
    }

    function setReward() private {
      reward[msg.sender] = amountStaked[msg.sender] * stakingDuration / inverseRewardRate;
    }

    function calculateReward(uint _amount) external view returns(uint){
        require(_amount != 0, "can't calculate reward for the value of 0");
     
        return _amount  * stakingDuration / inverseRewardRate;
    }
    
    function claimRewardToWallet() external{ 
        require(msg.sender != address(0), "Address zero detected");
     
        require(reward[msg.sender] != 0, "You don't have any reward");
     
        require(block.timestamp >= rewardTimeStamp[msg.sender]  + stakingDuration);       
     
        reward[msg.sender] = 0;
     
        amountStaked[msg.sender] = 0;
     
        walletBalance[msg.sender] = walletBalance[msg.sender] + reward[msg.sender] + amountStaked[msg.sender]; 
     
        emit RewardClaimed(msg.sender, reward[msg.sender]);
    }

    function withdrawFromWallet(uint _amount) external{
        require(msg.sender != address(0), "Address zero detected");
     
        require(walletBalance[msg.sender] > _amount, "You don't have enough balance in your wallet");

        walletBalance[msg.sender] = walletBalance[msg.sender] - _amount;

        require(IStakeToken(stakeToken).transfer(msg.sender, _amount), "failed to withdraw");

        emit WithdrawSuccessful(msg.sender, _amount);
    }

    function getStake(address __staker) external view  returns (uint) {
        return amountStaked[__staker];
    }

    function getReward(address __staker) external view returns (uint) {
        return reward[__staker];
    }

    function getWalletBalance(address __staker) external view returns (uint) {
        return walletBalance[__staker];
    }

    function getTotalWalletBalance() external view returns (uint) {
        return walletBalance[address(this)];
    }

    function getTotalStake() external view returns (uint)  {
        return amountStaked[address(this)];
    }

     function getTotalReward() external view returns (uint)  {
        return reward[address(this)];
    }
}