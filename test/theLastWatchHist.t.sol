pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import "src/theLastWatchHist.sol";

contract TheLastWatchHistTest is Test {
  TheLastWatchHist public tLWH;

  address public user;
  string  public ipfsURL;

  function setUp() public {
    tLWH = new TheLastWatchHist();
    tLWH.initialize("TheLastWatchHist", "TLWH");

    user = makeAddr("user");

    ipfsURL = "https://ipfs.io/ipfs/QmVBB9asE4uyhh4VLo2ai9sytcXVv5REGsQMrrMDqGi2J8";
  }

  function testDeploy() public {
    assertEq(tLWH.name(), "TheLastWatchHist");
    assertEq(tLWH.symbol(), "TLWH");
  }

  function testMintBurn() public {
    // Mint
    vm.prank(user);
    tLWH.mint(1, ipfsURL);

    assertEq(tLWH.ownerOf(1), user);
    assertEq(tLWH.tokenURI(1), ipfsURL);

    // Burn - only owner can burn
    vm.expectRevert("TheLastWatchHist: only owner can burn this token");
    tLWH.burn(1);

    vm.prank(user);
    tLWH.burn(1);

    assertEq(tLWH.balanceOf(user), 0);
  }

  function testOnlyOnMintPerAddress() public {
    // First Mint
    vm.prank(user);
    tLWH.mint(1, ipfsURL);

    assertEq(tLWH.balanceOf(user), 1);

    // Second Mint
    vm.prank(user);
    vm.expectRevert("TheLastWatchHist: only one mint is allowed per address");
    tLWH.mint(2, ipfsURL);

    assertEq(tLWH.balanceOf(user), 1);
  }
}
