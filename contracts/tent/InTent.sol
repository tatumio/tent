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
        grantRole(DEFAULT_ADMIN_ROLE, 0xf137CA6668e559bBEC308CBd63DCDd9b77214799);
        grantRole(MINTER_ROLE, 0xf137CA6668e559bBEC308CBd63DCDd9b77214799);
        grantRole(PAUSER_ROLE, 0xf137CA6668e559bBEC308CBd63DCDd9b77214799);
        renounceRole(DEFAULT_ADMIN_ROLE, _msgSender());
        mint(0x12F022370110956Ec7C83bc17B388D222bD2813C, 1200000000 * (10 ** uint256(decimals())));
        mint(0xC447A66eCC4E5eC202561c6a807BDb28f137319A, 600000000 * (10 ** uint256(decimals())));
        mint(0x38bc075E4EBa3Fc64C62217751A88f274Fa341bB, 200000000 * (10 ** uint256(decimals())));
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
