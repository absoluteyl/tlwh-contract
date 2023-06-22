pragma solidity ^0.8.19;

import "openzeppelin/token/ERC721/ERC721Upgradeable.sol";
import "openzeppelin/token/ERC721/extensions/ERC721EnumerableUpgradeable.sol";
import "openzeppelin/token/ERC721/extensions/ERC721URIStorageUpgradeable.sol";

contract TheLastWatchHist is ERC721Upgradeable, ERC721EnumerableUpgradeable, ERC721URIStorageUpgradeable {
  function initialize(string memory name, string memory symbol) external initializer {
    __ERC721_init(name, symbol);
    __ERC721Enumerable_init();
    __ERC721URIStorage_init();
  }

  function mint(uint256 tokenId, string memory tokenURI) external {
    require(balanceOf(msg.sender) == 0, "TheLastWatchHist: only one mint is allowed per address");

    _safeMint(msg.sender, tokenId);
    _setTokenURI(tokenId, tokenURI);
  }

  function burn(uint256 tokenId) external {
    address owner = ownerOf(tokenId);
    require(owner == msg.sender, "TheLastWatchHist: only owner can burn this token");

    _burn(tokenId);
  }

  // The following functions are overrides required by Solidity to solve inheritance ambiguity
  function _beforeTokenTransfer(address from, address to, uint256 tokenId, uint256 batchSize)
    internal
    override(ERC721Upgradeable, ERC721EnumerableUpgradeable)
  {
    super._beforeTokenTransfer(from, to, tokenId, batchSize);
  }

  function _burn(uint256 tokenId)
    internal
    override(ERC721Upgradeable, ERC721URIStorageUpgradeable)
  {
    super._burn(tokenId);
  }

  function tokenURI(uint256 tokenId)
    public
    view
    override(ERC721Upgradeable, ERC721URIStorageUpgradeable)
    returns (string memory)
  {
    return super.tokenURI(tokenId);
  }

  function supportsInterface(bytes4 interfaceId)
    public
    view
    override(ERC721Upgradeable, ERC721EnumerableUpgradeable, ERC721URIStorageUpgradeable)
    returns (bool)
  {
    return super.supportsInterface(interfaceId);
  }
}
