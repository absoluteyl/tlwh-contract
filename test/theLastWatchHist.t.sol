pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import "src/theLastWatchHist.sol";

contract TheLastWatchHistTest is Test {
  TheLastWatchHist public tLWH;

  address public user1;
  string  public ipfsHost;
  string  public ipfsId1;

  function setUp() public {
    tLWH = new TheLastWatchHist();
    tLWH.initialize("TheLastWatchHist", "TLWH");

    user1 = makeAddr("user1");

    ipfsHost = "https://ipfs.io/ipfs/";
    ipfsId1 = "QmVBB9asE4uyhh4VLo2ai9sytcXVv5REGsQMrrMDqGi2J8";

  }

  function testDeploy() public {
    assertEq(tLWH.name(), "TheLastWatchHist");
    assertEq(tLWH.symbol(), "TLWH");
  }

  function testMintBurn() public {
    // Mint
    vm.prank(user1);
    tLWH.mint(ipfsId1);

    assertEq(tLWH.ownerOf(0), user1);
    assertEq(tLWH.tokenURI(0), string.concat(ipfsHost, ipfsId1));

    // Burn - only owner can burn
    vm.expectRevert("ERC721: caller is not token owner or approved");
    tLWH.burn(0);

    vm.prank(user1);
    tLWH.burn(0);

    assertEq(tLWH.balanceOf(user1), 0);
  }

  function testOnlyOnMintPerAddress() public {
    // First Mint
    vm.prank(user1);
    tLWH.mint(ipfsId1);

    assertEq(tLWH.balanceOf(user1), 1);

    // Second Mint
    vm.prank(user1);
    vm.expectRevert("TheLastWatchHist: only one mint is allowed per address");
    tLWH.mint(ipfsId1);

    assertEq(tLWH.balanceOf(user1), 1);
  }
}
