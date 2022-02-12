// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import '@openzeppelin/contracts/access/Ownable.sol';
import '@openzeppelin/contracts/token/ERC20/IERC20.sol';
import '@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol';

contract MultiWallet {
    using SafeERC20 for IERC20;
    address[] public wallets;
        
    struct Wallet {
        address addressWallet;
        uint sharePercent;
    }
    
    constructor(string memory _nftName, string memory _nftSymbol, uint _devFeePercent, address _devFeeAddress, address _burnAddress, address _marketplaceAddress, address _tokenFactoryAddress, address _tokenProductAddress, address _tokenUpgradeAddress) ERC721MintMore(_nftName, _nftSymbol) {
        nftName = _nftName;
        nftSymbol = _nftSymbol;
        devFeePercent = _devFeePercent;
        devFeeAddress = _devFeeAddress;
        burnAddress = _burnAddress;
        marketplace = Marketplace(_marketplaceAddress);
        tokenFactory = IERC20Mint(_tokenFactoryAddress);
        tokenProduct = IERC20Mint(_tokenProductAddress);
        tokenUpgrade = IERC20Mint(_tokenUpgradeAddress);
    }

    function send(address _addressToken, uint _amount) public {
        IERC20 token = IERC20(_addressToken);
        require(token.allowance(msg.sender, address(this)) >= _amount, 'send: Token allowance is too low');
        token.safeTransferFrom(msg.sender, address(this), _amount);
        for (uint i = 0; i < wallets.length; i++) token.safeTransferFrom(address(this), wallets[i].addressWallet, _amount * wallets[i].sharePercent / 10000);
    }

    function addWallet(address _addressWallet, uint _sharePercent) public onlyOwner {
        uint totalShare;
        for (uint i = 0; i < wallets.length; i++) totalShare += wallets.sharePercent;
        require(totalShare + _share <= 10000, 'addWallet: Share exceeds 100 percent');
        wallets.push(Wallet(_address, _share));
    }
}
