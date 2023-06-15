pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import "src/theLastWatchHist.sol";

contract TheLastWatchHistTest is Test {
  TheLastWatchHist public tLWH;

  address public user;

  function setUp() public {
    tLWH = new TheLastWatchHist();
    tLWH.initialize();

    user = makeAddr("user");
  }

  function testDeploy() public {
    assertEq(tLWH.name(), "TheLastWatchHist");
    assertEq(tLWH.symbol(), "TLWH");
  }

  function testMint() public {
    tLWH.mint(user, 1);

    assertEq(tLWH.ownerOf(1), user);
  }
}
