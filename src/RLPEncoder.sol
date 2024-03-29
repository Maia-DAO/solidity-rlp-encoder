// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {RLPWriter} from "./rlp/RLPWriter.sol";
import {DynamicBufferLib} from "solady/utils/DynamicBufferLib.sol";

/**
 * @title RLPEncoder
 * @notice RLPEncoder handles Optimism's various different encoding schemes.
 * @author Maia DAO
 */
library RLPEncoder {
    using DynamicBufferLib for DynamicBufferLib.DynamicBuffer;

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
    function encodeCallData(bytes memory data, uint256 offset) internal pure returns (bytes memory) {
        uint256 length = data.length; // Length multiple of 32 assuming it comes from standard abi encode

        DynamicBufferLib.DynamicBuffer memory buffer;

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

        return RLPWriter.writeList(abi.encodePacked(buffer.data));
    }
}
