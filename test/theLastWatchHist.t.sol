pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import "src/theLastWatchHist.sol";
import "src/theLastWatchHistProxy.sol";

contract TheLastWatchHistTest is Test {
  TheLastWatchHistProxy public proxy;

  TheLastWatchHist public tLWH;
  TheLastWatchHist public proxiedTLWH;

  address public user1;
  address public user2;
  string  public ipfsHost;
  string  public ipfsId1;
  string  public ipfsId2;

  function setUp() public {
    tLWH = new TheLastWatchHist();
    proxy = new TheLastWatchHistProxy(
      abi.encodeWithSignature("initialize(string,string)", "TheLastWatchHist", "TLWH"),
      address(tLWH)
    );
    proxiedTLWH = TheLastWatchHist(address(proxy));

    user1 = makeAddr("user1");
    user2 = makeAddr("user2");

    ipfsHost = "https://ipfs.io/ipfs/";
    ipfsId1 = "QmVBB9asE4uyhh4VLo2ai9sytcXVv5REGsQMrrMDqGi2J8";
    ipfsId2 = "QmNmfAqjiQgdLJscpM3FufbaXY9QEqWZiWqDTbsrUjSKDR";

  }

  function testDeploy() public {
    assertEq(proxiedTLWH.name(), "TheLastWatchHist");
    assertEq(proxiedTLWH.symbol(), "TLWH");
  }

  function testMintBurn() public {
    // Mint
    vm.prank(user1);
    proxiedTLWH.mint(ipfsId1);

    assertEq(proxiedTLWH.ownerOf(0), user1);
    assertEq(proxiedTLWH.tokenURI(0), string.concat(ipfsHost, ipfsId1));

    // Burn - only owner can burn
    vm.expectRevert("ERC721: caller is not token owner or approved");
    proxiedTLWH.burn(0);

    vm.prank(user1);
    proxiedTLWH.burn(0);

    assertEq(proxiedTLWH.balanceOf(user1), 0);
  }

  function testOnlyOneMintPerAddress() public {
    // First Mint
    vm.prank(user1);
    proxiedTLWH.mint(ipfsId1);

    assertEq(proxiedTLWH.balanceOf(user1), 1);

    // Second Mint
    vm.prank(user1);
    vm.expectRevert("TheLastWatchHist: only one mint is allowed per address");
    proxiedTLWH.mint(ipfsId1);

    assertEq(proxiedTLWH.balanceOf(user1), 1);
  }

  function testTokenIdAutoIncrement() public {
    // User1 mints
    vm.prank(user1);
    proxiedTLWH.mint(ipfsId1);

    assertEq(proxiedTLWH.ownerOf(0), user1);
    assertEq(proxiedTLWH.tokenURI(0), string.concat(ipfsHost, ipfsId1));

    // User2 mints
    vm.prank(user2);
    proxiedTLWH.mint(ipfsId2);

    assertEq(proxiedTLWH.ownerOf(1), user2);
    assertEq(proxiedTLWH.tokenURI(1), string.concat(ipfsHost, ipfsId2));
  }

  function testTransferNotAllowed() public {
    // Mint
    vm.prank(user1);
    proxiedTLWH.mint(ipfsId1);

    assertEq(proxiedTLWH.balanceOf(user1), 1);

    // Transfer
    vm.prank(user1);
    vm.expectRevert("TheLastWatchHist: Token is soul-bound and not transferable");
    proxiedTLWH.transferFrom(user1, user2, 0);

    assertEq(proxiedTLWH.balanceOf(user1), 1);
    assertEq(proxiedTLWH.balanceOf(user2), 0);
  }
}
