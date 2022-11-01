// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { RLPWriter } from "./rlp/RLPWriter.sol";
import { RLPReader } from "./rlp/RLPReader.sol";
import {BufferChainlink} from "./BufferChainlink.sol";
import {console2} from "forge-std/console2.sol";

/**
 * @title RLPEncoder
 * @notice RLPEncoder handles Optimism's various different encoding schemes.
 * @author Maia DAO
 */
library RLPEncoder {
  using BufferChainlink for BufferChainlink.buffer;

    /**
     * @notice Encode provided calldata using RLP. Provides cheaper external calls in L2 networks.
     *
     * @param data from standard abi encoding.
     * @param offset Offset for data location in ´data´.
     *
     * @dev data is comprised the calldata parameters using standard abi encoding. 
     *
     * @return RLP encoded tx calldata.
     **/
    function encodeCallData(bytes memory data, uint256 offset) internal view returns (bytes memory) {
        uint length = data.length; // Length multiple of 32 assuming it comes from standard abi encode

        BufferChainlink.buffer memory buffer;
        // Initialize buffer with 32 bytes for each item
        BufferChainlink.init(buffer, length);

        // Reads concsucitve 32 bytes starting from offset
        for (uint256 i = offset + 32; i <= length; ) {

            uint256 slot;
            assembly {
                slot := mload(add(data, i)) // Get next 32 bytes
            }

            buffer.append(RLPWriter.writeUint(slot));      

            unchecked {
                i += 32; // Increase reading position by 32 bytes
            }
        }

        return RLPWriter.writeList(abi.encodePacked(buffer.buf));
    }

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

        BufferChainlink.buffer memory buffer;
        // Initialize buffer with 32 bytes for each item
        BufferChainlink.init(buffer, length * 32);

        for (uint256 i = 0; i < length; ) {
            bytes memory slot = RLPReader.readBytes(items[i]);

            // Right-shift signifcant bytes to restore padding
            bytes32 val = bytes32(slot) >> (256 - slot.length * 8);

            // Add extracted 32 bytes buffer
            buffer.appendBytes32(val);

            unchecked {
                i++;
            }
        }
        return buffer.buf;
    }
}
