// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable2Step.sol";

contract SOLV is ERC20, Ownable2Step {

    uint256 public accumulatedSupply;
    uint256 public constant MAX_SUPPLY = 8_400_000_000 * 1e18 * 2; //max supply on all chains
    uint256 public constant MAX_SUPPLY_PER_CHAIN = MAX_SUPPLY / 2; //max supply per chain ( ethereum and bnb chain )
    uint256 public constant INITIAL_SUPPLY_PERCENT = 50; //the initial supply is 50% of the max supply per chain
    uint256 public constant INITIAL_SUPPLY = MAX_SUPPLY_PER_CHAIN * INITIAL_SUPPLY_PERCENT / 100; //initial supply per chain

    uint256 public constant MINT_CYCLE = 3 * 30 * 24 * 60 * 60;
    uint256 public lastMintTimestamp;
    address public broContractAddress;
    bool public allowInflation;

    event BroContractAddressSet(address broContractAddress);

    constructor(address initialHolder) ERC20("Solv", "SOLV") Ownable(msg.sender) {
        _mint(initialHolder, INITIAL_SUPPLY);
        accumulatedSupply = INITIAL_SUPPLY;
        lastMintTimestamp = 0;
        allowInflation = true;
    }

    function mint() external onlyOwner {
        require(allowInflation, "Minting finished");
        require(broContractAddress != address(0), "Bro contract address not set");
        require(block.timestamp - lastMintTimestamp >= MINT_CYCLE, "Mint cycle not reached");
        uint256 amount = MAX_SUPPLY_PER_CHAIN * 5 / 100;
        require(accumulatedSupply + amount <= MAX_SUPPLY_PER_CHAIN, "Max supply reached");
        accumulatedSupply += amount;
        _mint(broContractAddress, amount);
        lastMintTimestamp = block.timestamp;
    }

    function stopInflation() external onlyOwner {
        allowInflation = false;
    }

    function setBroContractAddress(address _broContractAddress) external onlyOwner {
        broContractAddress = _broContractAddress;
        emit BroContractAddressSet(_broContractAddress);
    }

    function burn(uint256 amount) external onlyOwner {
        _burn(msg.sender, amount);
    }

}