pragma solidity ^0.8.19;

import "./tlwh.t.sol";

contract TLWHProxyTest is TLWHTest {
  function testDeploy() public {
    assertEq(proxiedTLWH.name(), "TheLastWatchHist");
    assertEq(proxiedTLWH.symbol(), "TLWH");
  }

  function testImplementationUninitializable() public {
    vm.expectRevert("Initializable: contract is already initialized");
    tLWH.initialize("TheLastWatchHist", "TLWH");
  }
}
