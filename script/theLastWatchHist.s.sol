pragma solidity 0.8.19;

import "forge-std/Script.sol";
import "src/theLastWatchHist.sol";

contract TheLastWatchHistScript is Script {
  function run() external {
    vm.startBroadcast(vm.envUint("WALLET_PRIVATE"));

    TheLastWatchHist tLWH = new TheLastWatchHist();
    tLWH.initialize("TheLastWatchHist", "TLWH");

    vm.stopBroadcast();
  }
}
