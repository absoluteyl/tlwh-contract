pragma solidity 0.8.19;

import "forge-std/Script.sol";
import "src/tlwhToken.sol";

contract TLWHScript is Script {
  function run() external {
    vm.startBroadcast(vm.envUint("WALLET_PRIVATE"));

    TLWHToken tLWH = new TLWHToken();
    tLWH.initialize("TheLastWatchHist", "TLWH");

    vm.stopBroadcast();
  }
}
