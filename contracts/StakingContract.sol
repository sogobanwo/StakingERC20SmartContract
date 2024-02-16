// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;
import "./IStakeToken.sol";

contract StakingContract {
    uint stakinDuration;
    uint rewardRate;
    uint maxStake;
    uint minStake;

    mapping (address => uint) amountStaked;
    mapping (address => uint) walletBalance;
    mapping (address => uint) reward;

    constructor(address _stakeToken, uint _stakinDuration, uint _rewardRate, uint _maxStake, uint _minStake) {
        
    }

    function stake(uint _amount) external{
        
    }

    function Unstake(uint _unstake) external{
        
    }
    
    function claimReward(address _staker) external{ 
        
    }

    function withdraw(uint _amount, address _staker) external{
        
    }

    function getStake(address __staker) external view  returns (uint) {
        return amountStaked[__staker];
    }

    function getReward(address __staker) external view returns (uint) {
        return reward[__staker];
    }

    function getTotalStake() external view returns (uint)  {
        return amountStaked[address(this)];
    }

     function getTotalReward() external view returns (uint)  {
        return reward[address(this)];
    }



}