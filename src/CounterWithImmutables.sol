// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract CounterWithImmutables {
  uint256 public immutable SCALE_FACTOR;
  uint256 public number;

  constructor(uint256 _scaleFactor) {
    SCALE_FACTOR = _scaleFactor;
  }

  function setNumber(uint256 newNumber) public {
    number = newNumber * SCALE_FACTOR;
  }

  function increment() public {
    number++;
  }
}
