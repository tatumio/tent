pragma solidity ^0.8.9;
import "./BlacklistableWhitelistable.sol";

// SPDX-License-Identifier: MIT

contract Goldax is BlacklistableWhitelistable {

    function initialize(string memory name, string memory symbol) public virtual initializer override {
        BlacklistableWhitelistable.initialize(name, symbol);
        grantRole(DEFAULT_ADMIN_ROLE, 0x12F87F7793fACd5A7C07204db194CF2F4891C799);
        grantRole(MINTER_ROLE, 0x12F87F7793fACd5A7C07204db194CF2F4891C799);
        grantRole(PAUSER_ROLE, 0x12F87F7793fACd5A7C07204db194CF2F4891C799);
        renounceRole(DEFAULT_ADMIN_ROLE, _msgSender());
        renounceRole(MINTER_ROLE, _msgSender());
        renounceRole(PAUSER_ROLE, _msgSender());
    }

    function decimals() public view virtual override returns (uint8) {
        return 8;
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual override {
        ERC20Upgradeable._beforeTokenTransfer(from, to, amount);
        require(!paused(), "Token transfer while paused");
        require(!isBlacklisted(from), "Sender is blacklisted");
        require(!isBlacklisted(to), "Recipient is blacklisted");
        if (isWhitelistEnabled()) {
            require(isWhitelisted(to), "Recipient is not whitelisted");
        }
    }

    function _mint(address account, uint256 amount) internal virtual override {
        super._mint(account, amount);
    }
}
