pragma solidity ^0.8.9;

// SPDX-License-Identifier: MIT
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/presets/ERC20PresetMinterPauserUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20CappedUpgradeable.sol";


abstract contract BlacklistableWhitelistable is ERC20PresetMinterPauserUpgradeable {
    
    bool internal whitelistEnabled;
    
    mapping(address => bool) internal blacklisted;
    mapping(address => bool) internal whitelisted;

    event Blacklisted(address indexed _account);
    event Whitelisted(address indexed _account);

    function initialize(string memory name, string memory symbol) public virtual initializer override {
        super.initialize(name, symbol);
        whitelistEnabled = false;
    }
    
    function isBlacklisted(address _account) public view returns (bool) {
        return blacklisted[_account];
    }

    function isWhitelisted(address _account) public view returns (bool) {
        return whitelisted[_account];
    }
    
    function isWhitelistEnabled() public view returns (bool) {
        return whitelistEnabled;
    }

    function blacklist(address _account) public virtual {
        require(hasRole(DEFAULT_ADMIN_ROLE, _msgSender()), "Sender must have admin role to blacklist");
        blacklisted[_account] = true;
        emit Blacklisted(_account);
    }

    function unBlacklist(address _account) public virtual {
        require(hasRole(DEFAULT_ADMIN_ROLE, _msgSender()), "Sender must have admin role to unBlacklist");
        blacklisted[_account] = false;
    }

    function setWhitelist(bool state) public virtual {
        require(hasRole(DEFAULT_ADMIN_ROLE, _msgSender()), "Sender must have admin role to change whitelist state");
        whitelistEnabled = state;
    }
    
    function whitelist(address _account) public virtual {
        require(hasRole(DEFAULT_ADMIN_ROLE, _msgSender()), "Sender must have admin role to whitelist");
        whitelisted[_account] = true;
        emit Whitelisted(_account);
    }
    
    function unWhitelist(address _account) public virtual {
        require(hasRole(DEFAULT_ADMIN_ROLE, _msgSender()), "Sender must have admin role to unWhitelist");
        whitelisted[_account] = false;
    }
}
