pragma solidity 0.8.19;

import "forge-std/Script.sol";
import "src/tlwhToken.sol";
import "src/tlwhProxy.sol";

contract TLWHScript is Script {
  function run() external {
    vm.startBroadcast(vm.envUint("WALLET_PRIVATE"));

    TLWHToken token = new TLWHToken();
    new TLWHProxy(
      address(token),
      abi.encodeWithSignature("initialize(string,string)", "TheLastWatchHist", "TLWH")
    );

    vm.stopBroadcast();
  }
}
