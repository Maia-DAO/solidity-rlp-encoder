// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.0;

import {RLPEncoder} from "../../src/RLPEncoder.sol";
import {console2} from "forge-std/console2.sol";

library RLPEncoderHelper {
    // Encodes and decodes bytes using RLPEncoder contract for testing
    function encodeAndDecode(bytes memory data, uint256 offset) internal view returns (bytes memory) {
        bytes memory encodedData = RLPEncoder.encodeCallData(data, offset);
        console2.logBytes(data);
        console2.logBytes(encodedData);

        return RLPEncoder.decodeCallData(encodedData, 1 + data.length / 32);
    }
}
