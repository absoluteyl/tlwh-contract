pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import "src/tlwhToken.sol";
import "src/tlwhProxy.sol";

contract TLWHTest is Test {
  TLWHProxy public proxy;

  TLWHToken public tLWH;
  TLWHToken public proxiedTLWH;

  function setUp() public virtual {
    tLWH = new TLWHToken();
    proxy = new TLWHProxy(
      abi.encodeWithSignature("initialize(string,string)", "TheLastWatchHist", "TLWH"),
      address(tLWH)
    );
    proxiedTLWH = TLWHToken(address(proxy));
  }
}
