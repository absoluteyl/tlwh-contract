// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./tlwh.t.sol";

contract TLWHProxyTest is TLWHTest {
  TLWHToken public tLWHV2;
  TLWHToken public proxiedTLWHV2;

  function testDeploy() public {
    assertEq(proxiedTLWH.name(), "TheLastWatchHist");
    assertEq(proxiedTLWH.symbol(), "TLWH");
  }

  function testImplementationUninitializable() public {
    vm.expectRevert("Initializable: contract is already initialized");
    tLWH.initialize("TheLastWatchHist", "TLWH");

    assertEq(tLWH.name(), "");
    assertEq(tLWH.symbol(), "");
  }

  function testUpgrade() public {
    tLWHV2 = new TLWHToken();
    proxiedTLWH.upgradeTo(address(tLWHV2));
    proxiedTLWHV2 = TLWHToken(address(proxy));

    // TODO: currently only run upgrade steps,
    // should verify implementation address DID changed.
  }
}
