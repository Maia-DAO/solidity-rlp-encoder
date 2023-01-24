// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {RLPReader} from "./rlp/RLPReader.sol";
import {DynamicBufferLib} from "./DynamicBufferLib.sol";

/**
 * @title RLPDecoder
 * @notice RLPDecoder handles Optimism's various different encoding schemes.
 * @author Maia DAO
 */
library RLPDecoder {
    using DynamicBufferLib for DynamicBufferLib.DynamicBuffer;

    /**
     * @notice Decode provided RLP encoded data into calldata. Provides cheaper external calls in L2 networks.
     *
     * @param data RLP encoded calladata to decode.
     *
     * @dev data is comprised of the calldata parameters without padding.
     *
     * @return bytes standard abi encoded tx calldata.
     **/
    function decodeCallData(bytes memory data, uint256 maxListLength) internal pure returns (bytes memory) {
        // Get RLP item list from data
        RLPReader.RLPItem[] memory items = RLPReader.readList(data, maxListLength);

        uint256 length = items.length;

        DynamicBufferLib.DynamicBuffer memory buffer;

        for (uint256 i = 0; i < length; ) {
            bytes memory slot = RLPReader.readBytes(items[i]);

            // Right-shift signifcant bytes to restore padding
            bytes32 val = bytes32(slot) >> (256 - slot.length * 8);

            // Add extracted 32 bytes buffer
            buffer.append(abi.encodePacked(val));

            unchecked {
                i++;
            }
        }
        return buffer.data;
    }
}
