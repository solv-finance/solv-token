// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable2Step.sol";

contract SOLV is ERC20, Ownable2Step {

    uint256 public accumulatedSupply;
    uint256 public constant MAX_SUPPLY = 8_400_000_000 * 1e18;
    uint256 public constant MINT_CYCLE = 3 * 30 * 24 * 60 * 60;
    uint256 public lastMintTimestamp;
    address public broContractAddress;
    bool public allowInflation;

   event BroContractAddressSet(address broContractAddress);

    constructor() ERC20("Solv", "SOLV") Ownable(msg.sender) {
        accumulatedSupply = 0;
        lastMintTimestamp = 0;
        allowInflation = true;
    }

    function mint() external onlyOwner {
        require(allowInflation, "Minting finished");
        require(block.timestamp - lastMintTimestamp >= MINT_CYCLE, "Mint cycle not reached");
        require(broContractAddress != address(0), "Bro contract address not set");
        uint256 amount = MAX_SUPPLY * 5 / 100;
        require(accumulatedSupply + amount <= MAX_SUPPLY, "Max supply reached");
        accumulatedSupply += amount;
        _mint(broContractAddress, amount);
        lastMintTimestamp = block.timestamp;
    }

    function stopInflation() external onlyOwner {
        allowInflation = false;
    }

    function burn(uint256 amount) external onlyOwner {
        _burn(msg.sender, amount);
    }

    function setBroContractAddress(address _broContractAddress) external onlyOwner {
        broContractAddress = _broContractAddress;
        emit BroContractAddressSet(_broContractAddress);
    }

}