/* SPDX-License-Identifier: MIT */
pragma solidity 0.8.6;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

import "./ReserveEscrow.sol";

contract DeStake is ERC20 {
    uint256 public lockupPeriod;
    address public tokenAddress;
    ReserveEscrow private _reserveEscrow;



    constructor(uint256 _lockupPeriod, address _tokenAddress, string memory name, string memory symbol) ERC20(name, symbol) {
        lockupPeriod = _lockupPeriod;
        tokenAddress = _tokenAddress;
        require(_tokenAddress != address(0), "Token address cannot be 0");
        _reserveEscrow = new ReserveEscrow(_tokenAddress);
    }

    function calcGrtRedemptionValue() public view returns (uint256) {
        // Get total balance of GRT
        // Get Reserve total
        // (balance - reserve) / supply
        uint256 balance = IERC20(tokenAddress).balanceOf(address(this));
        uint256 reserve = IERC20(tokenAddress).balanceOf(address(_reserveEscrow));
        // Should be slightly less than 1
        return (balance - reserve) / IERC20(address(this)).totalSupply();


    }    
}
