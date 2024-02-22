// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.24;

interface IStakingContract {
    function depositToWallet(uint _amount) external;

    function stake(uint _amount) external;

    function getTotalStake() external view returns (uint) ;

    function claimRewardToWallet() external;

    function withdrawFromWallet(uint _amount) external;
}