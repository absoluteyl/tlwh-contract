// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Proxy.sol";

contract TLWHProxy is ERC1967Proxy {
  constructor(
    address _logic, bytes memory _initCode
  ) ERC1967Proxy(_logic, _initCode) {}
}
