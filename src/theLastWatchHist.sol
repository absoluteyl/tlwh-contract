pragma solidity ^0.8.19;

import "openzeppelin/token/ERC721/extensions/ERC721URIStorageUpgradeable.sol";

contract TheLastWatchHist is ERC721URIStorageUpgradeable {
  function initialize(string memory name, string memory symbol) external initializer {
    __ERC721_init(name, symbol);
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
}
