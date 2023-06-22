pragma solidity ^0.8.19;

import "openzeppelin/token/ERC721/ERC721Upgradeable.sol";
import "openzeppelin/token/ERC721/extensions/ERC721EnumerableUpgradeable.sol";
import "openzeppelin/token/ERC721/extensions/ERC721URIStorageUpgradeable.sol";
import "openzeppelin/token/ERC721/extensions/ERC721BurnableUpgradeable.sol";
import "openzeppelin/utils/CountersUpgradeable.sol";

contract TheLastWatchHist is ERC721Upgradeable, ERC721EnumerableUpgradeable, ERC721URIStorageUpgradeable, ERC721BurnableUpgradeable {
  using CountersUpgradeable for CountersUpgradeable.Counter;

  CountersUpgradeable.Counter private _tokenIdCounter;

  function initialize(string memory name, string memory symbol) external initializer {
    __ERC721_init(name, symbol);
    __ERC721Enumerable_init();
    __ERC721URIStorage_init();
    __ERC721Burnable_init();
  }

  function mint(string memory _tokenURI) external {
    require(balanceOf(msg.sender) == 0, "TheLastWatchHist: only one mint is allowed per address");

    uint256 _tokenId = _tokenIdCounter.current();
    _tokenIdCounter.increment();

    _safeMint(msg.sender, _tokenId);
    _setTokenURI(_tokenId, _tokenURI);
  }

  ////////////////////////
  // Internal Functions

  function _baseURI() internal pure override returns (string memory) {
    return "https://ipfs.io/ipfs/";
  }

  function _beforeTokenTransfer(address from, address to, uint256 tokenId, uint256 batchSize)
    internal
    override(ERC721Upgradeable, ERC721EnumerableUpgradeable)
  {
    require(from == address(0) || to == address(0), "TheLastWatchHist: Token is soul-bound and not transferable");
    super._beforeTokenTransfer(from, to, tokenId, batchSize);
  }

  // The following functions are overrides required by Solidity to solve inheritance ambiguity
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
