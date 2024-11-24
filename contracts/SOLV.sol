// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable2Step.sol";

contract SOLV is ERC20, Ownable2Step {

    uint256 public hardCap;
    uint256 public constant INITIAL_SUPPLY = 8_400_000_000 * 1e18;

    constructor(address initialHolder) ERC20("Solv", "SOLV") Ownable2Step(msg.sender) {
        hardCap = INITIAL_SUPPLY * 2;
        _mint(initialHolder, INITIAL_SUPPLY);
    }

    function mint(address to) external onlyOwner {
        require(totalSupply() + amount <= hardCap, "Hard cap reached");
        uint256 amount = INITIAL_SUPPLY * 5 / 100;
        _mint(to, amount);
    }

    function burn(uint256 amount) external onlyOwner {
        hardCap -= amount;
        _burn(msg.sender, amount);
    }

}