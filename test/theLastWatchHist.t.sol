pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import "src/theLastWatchHist.sol";

contract TheLastWatchHistTest is Test {
  TheLastWatchHist public tLWH;

  address public user;
  string  public ipfsHost;
  string  public ipfsId;

  function setUp() public {
    tLWH = new TheLastWatchHist();
    tLWH.initialize("TheLastWatchHist", "TLWH");

    user = makeAddr("user");

    ipfsHost = "https://ipfs.io/ipfs/";
    ipfsId = "QmVBB9asE4uyhh4VLo2ai9sytcXVv5REGsQMrrMDqGi2J8";

  }

  function testDeploy() public {
    assertEq(tLWH.name(), "TheLastWatchHist");
    assertEq(tLWH.symbol(), "TLWH");
  }

  function testMintBurn() public {
    // Mint
    vm.prank(user);
    tLWH.mint(ipfsId);

    assertEq(tLWH.ownerOf(0), user);
    assertEq(tLWH.tokenURI(0), string.concat(ipfsHost, ipfsId));

    // Burn - only owner can burn
    vm.expectRevert("ERC721: caller is not token owner or approved");
    tLWH.burn(0);

    vm.prank(user);
    tLWH.burn(0);

    assertEq(tLWH.balanceOf(user), 0);
  }

  function testOnlyOnMintPerAddress() public {
    // First Mint
    vm.prank(user);
    tLWH.mint(ipfsId);

    assertEq(tLWH.balanceOf(user), 1);

    // Second Mint
    vm.prank(user);
    vm.expectRevert("TheLastWatchHist: only one mint is allowed per address");
    tLWH.mint(ipfsId);

    assertEq(tLWH.balanceOf(user), 1);
  }
}
