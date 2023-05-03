// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {CounterBasic} from "src/CounterBasic.sol";
import {CounterWithImmutables} from "src/CounterWithImmutables.sol";

contract DeployCounters is Script {
  function run() public {
    vm.startBroadcast();
    CounterBasic counterBasic1 = new CounterBasic();
    CounterBasic counterBasic2 = new CounterBasic{salt: salt()}();
    CounterWithImmutables counterWithImmutables1 = new CounterWithImmutables(scaleFactor());
    CounterWithImmutables counterWithImmutables2 =
      new CounterWithImmutables{salt: salt()}(scaleFactor());
    vm.stopBroadcast();

    console2.log("FOUNDRY_PROFILE: %s", vm.envString("FOUNDRY_PROFILE"));
    console2.log("CounterBasic             create     %s", address(counterBasic1));
    console2.log("CounterWithImmutables    create     %s", address(counterWithImmutables1));
    console2.log("CounterBasic             create2    %s", address(counterBasic2));
    console2.log("CounterWithImmutables    create2    %s", address(counterWithImmutables2));
  }

  function salt() internal view returns (bytes32) {
    return keccak256(abi.encodePacked(vm.envString("FOUNDRY_PROFILE")));
  }

  function scaleFactor() internal view returns (uint256) {
    string memory profileName = vm.envString("FOUNDRY_PROFILE");
    if (isEqual(profileName, "default")) return 10;
    else if (isEqual(profileName, "no_optimizer_no_metadata")) return 20;
    else if (isEqual(profileName, "yes_optimizer_no_metadata")) return 30;
    else if (isEqual(profileName, "no_via_ir_no_metadata")) return 40;
    else if (isEqual(profileName, "yes_via_ir_no_metadata")) return 50;
    else if (isEqual(profileName, "no_metadata_no_cbor")) return 60;
    else if (isEqual(profileName, "no_metadata_yes_cbor")) return 70;
    revert("unknown profile");
  }

  function isEqual(string memory a, string memory b) internal pure returns (bool) {
    return keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked((b)));
  }
}
