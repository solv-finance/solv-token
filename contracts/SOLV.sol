// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract SOLV is ERC20 {

    constructor(address initialHolder) ERC20("Solv", "SOLV") {
        uint256 totalSupply = 8_400_000_000 * 1e18;
        _mint(initialHolder, totalSupply);
    }

}