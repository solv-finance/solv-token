// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable2Step.sol";

contract SOLV is ERC20, Ownable2Step {

    uint256 public accumulatedSupply;
    uint256 public constant INITIAL_SUPPLY = 8_400_000_000 * 1e18;
    uint256 public constant MAX_SUPPLY = INITIAL_SUPPLY * 2;
    uint256 public constant MINT_CYCLE = 3 * 30 * 24 * 60 * 60;
    uint256 public lastMintTimestamp;
    bool public allowInflation;

    constructor(address initialHolder) ERC20("Solv", "SOLV") Ownable(msg.sender) {
        _mint(initialHolder, INITIAL_SUPPLY);
        accumulatedSupply = INITIAL_SUPPLY;
        lastMintTimestamp = 0;
        allowInflation = true;
    }

    function mint(address to) external onlyOwner {
        require(allowInflation, "Minting finished");
        require(block.timestamp - lastMintTimestamp >= MINT_CYCLE, "Mint cycle not reached");
        uint256 amount = INITIAL_SUPPLY * 5 / 100;
        require(accumulatedSupply + amount <= MAX_SUPPLY, "Max supply reached");
        accumulatedSupply += amount;
        _mint(to, amount);
        lastMintTimestamp = block.timestamp;
    }

    function stopInflation() external onlyOwner {
        allowInflation = false;
    }

    function burn(uint256 amount) external onlyOwner {
        _burn(msg.sender, amount);
    }

}