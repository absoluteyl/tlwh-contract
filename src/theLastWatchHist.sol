pragma solidity ^0.8.19;

import "openzeppelin/token/ERC721/ERC721Upgradeable.sol";

contract TheLastWatchHist is  ERC721Upgradeable {
  function initialize() public initializer {
    __ERC721_init("TheLastWatchHist", "TLWH");
  }

  function mint(address to, uint256 tokenId) external {
    _safeMint(to, tokenId);
  }
}
