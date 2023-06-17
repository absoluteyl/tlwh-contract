pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import "src/theLastWatchHist.sol";

contract TheLastWatchHistTest is Test {
  TheLastWatchHist public tLWH;

  address public user;
  string  public ipfsURL;

  function setUp() public {
    tLWH = new TheLastWatchHist();
    tLWH.initialize();

    user = makeAddr("user");

    ipfsURL = "https://ipfs.io/ipfs/QmVBB9asE4uyhh4VLo2ai9sytcXVv5REGsQMrrMDqGi2J8";
  }

  function testDeploy() public {
    assertEq(tLWH.name(), "TheLastWatchHist");
    assertEq(tLWH.symbol(), "TLWH");
  }

  function testMint() public {
    tLWH.mint(user, 1, ipfsURL);

    assertEq(tLWH.ownerOf(1), user);
    assertEq(tLWH.tokenURI(1), ipfsURL);
  }
}
