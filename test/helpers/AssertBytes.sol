// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.0;

import {RLPEncoder} from "../../src/RLPEncoder.sol";

library AssertBytes {
    // Encodes and decodes bytes using RLPEncoder contract for testing
    function equal(bytes memory in0, bytes memory out0) internal pure returns (bool) {
        return out0.length == in0.length && keccak256(out0) == keccak256(in0);
    }
}
