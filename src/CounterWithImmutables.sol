// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract CounterWithImmutables {
  uint256 public immutable scaleFactor;
  uint256 public number;

  constructor(uint256 _scaleFactor) {
    scaleFactor = _scaleFactor;
  }

  function setNumber(uint256 newNumber) public {
    number = newNumber * scaleFactor;
  }

  function increment() public {
    number++;
  }
}
