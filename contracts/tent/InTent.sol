pragma solidity ^0.8.9;

// SPDX-License-Identifier: MIT
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/presets/ERC20PresetMinterPauserUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20CappedUpgradeable.sol";
import "./BlacklistableWhitelistable.sol";

contract InTent is ERC20CappedUpgradeable, BlacklistableWhitelistable {

    function decimals() public view virtual override returns (uint8) {
        return 8;
    }
    
    function initialize(string memory name, string memory symbol) public virtual initializer override {
        BlacklistableWhitelistable.initialize(name, symbol);
        ERC20CappedUpgradeable.__ERC20Capped_init(2000000000 * (10 ** uint256(decimals())));
        grantRole(DEFAULT_ADMIN_ROLE, 0x12F87F7793fACd5A7C07204db194CF2F4891C799);
        grantRole(MINTER_ROLE, 0x12F87F7793fACd5A7C07204db194CF2F4891C799);
        grantRole(PAUSER_ROLE, 0x12F87F7793fACd5A7C07204db194CF2F4891C799);
        renounceRole(DEFAULT_ADMIN_ROLE, _msgSender());
        mint(0x12F87F7793fACd5A7C07204db194CF2F4891C799, 1200000000 * (10 ** uint256(decimals())));
        mint(0x0E84C8ac5a00e3300Ff51cC9cEcAa5f9eF5587d9, 500000000 * (10 ** uint256(decimals())));
        mint(0x96564eBb48EEF8C2EaF2888716b9230D8f9ebeb3, 300000000 * (10 ** uint256(decimals())));
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual override(ERC20Upgradeable, ERC20PresetMinterPauserUpgradeable) {
        ERC20Upgradeable._beforeTokenTransfer(from, to, amount);
        require(!paused(), "Token transfer while paused");
        require(!isBlacklisted(from), "Sender is blacklisted");
        require(!isBlacklisted(to), "Recipient is blacklisted");
        if (isWhitelistEnabled()) {
            require(isWhitelisted(to), "Recipient is not whitelisted");
        }
    }
    
    function _mint(address account, uint256 amount) internal virtual override (ERC20CappedUpgradeable, ERC20Upgradeable) {
        ERC20CappedUpgradeable._mint(account, amount);
    }
}
