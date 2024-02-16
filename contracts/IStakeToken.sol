// SPDX-License-Identifier: SMIT
pragma solidity ^0.8.0;

interface IStakeToken {
    function balanceOf(address _owner) external view returns (uint256);

    function transfer( address _to,  uint256 _value ) external returns (bool);

    function transferFrom( address _from, address _to, uint256 _value ) external returns (bool);

    function approve( address _spender, int256 _value ) external returns (bool);
}
