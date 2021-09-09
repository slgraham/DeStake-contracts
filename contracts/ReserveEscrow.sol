/* SPDX-License-Identifier: MIT */
pragma solidity 0.8.6;


import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract ReserveEscrow is Ownable{
    IERC20 public token;

    event Withdrawal(address indexed receiver, uint256 amount,  uint256 balance);
    
    constructor(address _tokenAddress) public {
        token = IERC20(_tokenAddress);
    }

    function withdraw(address receiver, uint256 amount) public onlyOwner returns (bool) {
        uint256 balance = token.balanceOf(address(this));
        require(balance >= amount, "Cannot withdraw more than the balance");
        emit Withdrawal(receiver, amount, balance);
        return token.transfer(receiver, amount);
    }

}