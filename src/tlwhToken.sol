// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "openzeppelin-contracts-upgradeable/contracts/token/ERC721/ERC721Upgradeable.sol";
import "openzeppelin-contracts-upgradeable/contracts/token/ERC721/extensions/ERC721EnumerableUpgradeable.sol";
import "openzeppelin-contracts-upgradeable/contracts/token/ERC721/extensions/ERC721URIStorageUpgradeable.sol";
import "openzeppelin-contracts-upgradeable/contracts/token/ERC721/extensions/ERC721BurnableUpgradeable.sol";
import "openzeppelin-contracts-upgradeable/contracts/access/OwnableUpgradeable.sol";
import "openzeppelin-contracts-upgradeable/contracts/proxy/utils/Initializable.sol";
import "openzeppelin-contracts-upgradeable/contracts/proxy/utils/UUPSUpgradeable.sol";
import "openzeppelin-contracts-upgradeable/contracts/utils/CountersUpgradeable.sol";

contract TLWHToken is
  ERC721Upgradeable, ERC721EnumerableUpgradeable, ERC721URIStorageUpgradeable, ERC721BurnableUpgradeable,
  OwnableUpgradeable, UUPSUpgradeable
{
  using CountersUpgradeable for CountersUpgradeable.Counter;

  CountersUpgradeable.Counter private _tokenIdCounter;

  constructor () {
    _disableInitializers();
  }

  function initialize(string memory name, string memory symbol) external initializer {
    __ERC721_init(name, symbol);
    __ERC721Enumerable_init();
    __ERC721URIStorage_init();
    __ERC721Burnable_init();
    __Ownable_init();
    __UUPSUpgradeable_init();
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

  // For UUPS Proxy
  function _authorizeUpgrade(address newImplementation)
    internal
    onlyOwner
    override
  {}

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
