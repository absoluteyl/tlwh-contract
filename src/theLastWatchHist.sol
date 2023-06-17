pragma solidity ^0.8.19;

import "openzeppelin/token/ERC721/extensions/ERC721URIStorageUpgradeable.sol";

contract TheLastWatchHist is ERC721URIStorageUpgradeable {
  function initialize(string memory name, string memory symbol) external initializer {
    __ERC721_init(name, symbol);
  }

  function mint(address to, uint256 tokenId, string memory tokenURI) external {
    _safeMint(to, tokenId);
    _setTokenURI(tokenId, tokenURI);
  }

  function burn(uint256 tokenId) external {
    _burn(tokenId);
  }
}
