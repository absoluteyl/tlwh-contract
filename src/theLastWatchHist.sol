pragma solidity ^0.8.19;

import "openzeppelin/token/ERC721/extensions/ERC721URIStorageUpgradeable.sol";

contract TheLastWatchHist is ERC721URIStorageUpgradeable {
  function initialize() external initializer {
    __ERC721_init("TheLastWatchHist", "TLWH");
  }

  function mint(address to, uint256 tokenId) external {
    _safeMint(to, tokenId);
  }
}
