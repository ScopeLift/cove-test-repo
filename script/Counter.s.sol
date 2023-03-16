// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import {Counter} from "src/Counter.sol";

contract DeployCounter is Script {
  function run() public {
    vm.broadcast();
    new Counter();
  }
}
