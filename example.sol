// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts@5.0.2/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts@5.0.2/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts@5.0.2/access/Ownable.sol";
import "@openzeppelin/contracts@5.0.2/token/ERC20/extensions/ERC20Permit.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";

interface IInscription404 {
    event TransferToken(
        address indexed from,
        address indexed to,
        uint256 amount,
        uint256 decimal
    );

    event TransferNFT(
        address indexed from,
        address indexed to,
        uint256 amount,
        uint256 tokenId,
        uint8 decimal
    );

    // function deploy(
    //     uint8 d
    // ) external;

    function tokenURI(uint256 tokenId) external view returns (string memory);

    function transferToken(uint256 tokenID, address recipient)
        external
        returns (bool);

    function transferTokenFrom(
        uint256 tokenID,
        address sender,
        address recipient
    ) external returns (bool);
}

contract MyToken is ERC20, ERC20Burnable, Ownable, ERC20Permit, IInscription404 {
    using Strings for uint256;

    constructor(address initialOwner)
        ERC20("MyToken", "MTK")
        Ownable(initialOwner)
        ERC20Permit("MyToken")
    {}
    string public baseURI = "";

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
        emit TransferToken(address(0), to, amount, decimals());
    }

    function burn(address account, uint256 amount) public onlyOwner {
        _burn(account, amount);
        emit TransferToken(account,address(0),  amount, decimals());
    }


    function tokenURI(uint256 tokenId) external view returns (string memory) {
                return    bytes(baseURI).length > 0
                ? string.concat(baseURI, tokenId.toString())
                : "";
    }

    function transferToken(uint256 tokenID, address recipient)
        external
        returns (bool)
    {
        uint256 amount = 1 * 10**decimals();
        address owner = _msgSender();

        ERC20.transfer(recipient, amount);
        emit TransferNFT(owner, recipient, amount, tokenID, decimals());
        return true;
    }

    function transferTokenFrom(
        uint256 tokenID,
        address sender,
        address recipient
    ) external returns (bool) {
        uint256 amount = 1 * 10**decimals();
        // address owner = _msgSender();

        ERC20.transferFrom(sender, recipient, amount);
        emit TransferNFT(sender, recipient, amount, tokenID, decimals());
        return true;
    }

    function transfer(address to, uint256 value) public virtual override  returns (bool) {
        address owner = _msgSender();

        ERC20.transfer(to, value);

        emit TransferToken(owner, to, value, decimals());

        return true;
    }


    function transferFrom(address from, address to, uint256 value) public virtual override returns (bool) {
        
        ERC20.transferFrom(from, to, value);

        emit TransferToken(from, to, value, decimals());

        return true;
    }

}
