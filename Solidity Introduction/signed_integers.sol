// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    int8 public a = 50;
    int8 public b = -20;

    int16 public difference = int16(a - b);
}