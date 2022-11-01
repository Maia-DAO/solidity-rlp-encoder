// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.0;

import {console2} from "forge-std/console2.sol";

import {DSTestPlus} from "solmate/test/utils/DSTestPlus.sol";
import {RLPEncoderHelper} from "./helpers/RLPEncoderHelper.sol";
import {AssertBytes} from "./helpers/AssertBytes.sol";

contract RLPEncoderTestBytes is DSTestPlus {

    function testRLPEncoderBytesPreset() public {
        bytes memory in0 = "Hello";
        bytes memory in1 = "World";
        bytes memory in2 = "!";

        bytes memory buf = RLPEncoderHelper.encodeAndDecode(abi.encode(in0, in1, in2), 0);

        (bytes memory out0, bytes memory out1, bytes memory out2) = abi.decode(buf, (bytes, bytes, bytes));
        assertTrue(AssertBytes.equal(out0, in0), "Output 0 mismatch");
        assertTrue(AssertBytes.equal(out1, in1), "Output 1 mismatch");
        assertTrue(AssertBytes.equal(out2, in2), "Output 2 mismatch");
    }

    function testRLPEncoderTest() public {
        bytes memory in0 = hex'2a';
        bytes memory buf = RLPEncoderHelper.encodeAndDecode(abi.encode(in0), 0);

        bytes memory out0 = abi.decode(buf, (bytes));
        assertTrue(AssertBytes.equal(in0, out0), "Output 0 mismatch");
    }

    function testRLPEncoderBytes(bytes memory in0) public {
        bytes memory buf = RLPEncoderHelper.encodeAndDecode(abi.encode(in0), 0);

        bytes memory out0 = abi.decode(buf, (bytes));
        assertTrue(AssertBytes.equal(out0, in0), "Output 0 mismatch");
    }

    function testRLPEncoderBytesBytes(bytes memory in0, bytes memory in1) public {
        bytes memory buf = RLPEncoderHelper.encodeAndDecode(abi.encode(in0, in1), 0);

        (bytes memory out0, bytes memory out1) = abi.decode(buf, (bytes, bytes));
        assertTrue(AssertBytes.equal(out0, in0), "Output 0 mismatch");
        assertTrue(AssertBytes.equal(out1, in1), "Output 1 mismatch");
    }

    function testRLPEncoderBytesBytesBytes(bytes memory in0, bytes memory in1, bytes memory in2) public {
        bytes memory buf = RLPEncoderHelper.encodeAndDecode(abi.encode(in0, in1, in2), 0);

        (bytes memory out0, bytes memory out1, bytes memory out2) = abi.decode(buf, (bytes, bytes, bytes));
        assertTrue(AssertBytes.equal(out0, in0), "Output 0 mismatch");
        assertTrue(AssertBytes.equal(out1, in1), "Output 1 mismatch");
        assertTrue(AssertBytes.equal(out2, in2), "Output 2 mismatch");
    }

    function testRLPEncoderBytesArray(bytes[] memory in0) public {
        bytes memory buf = RLPEncoderHelper.encodeAndDecode(abi.encode(in0), 0);

        bytes[] memory out0 = abi.decode(buf, (bytes[]));
        for (uint256 i = 0; i < out0.length; i++) {
            if (i < in0.length) {
                assertTrue(AssertBytes.equal(out0[i], in0[i]), "Output 0 mismatch");
            } else {
                assertTrue(AssertBytes.equal(out0[i], new bytes(0)), "Output 0 mismatch");
            }
        }
    }

    function testRLPEncoderBytesArrayBytesArray(bytes[] memory in0, bytes[] memory in1) public {
        bytes memory buf = RLPEncoderHelper.encodeAndDecode(abi.encode(in0, in1), 0);

        (bytes[] memory out0, bytes[] memory out1) = abi.decode(buf, (bytes[], bytes[]));
        for (uint256 i = 0; i < out0.length; i++) {
            if (i < in0.length) {
                assertTrue(AssertBytes.equal(out0[i], in0[i]), "Output 0 mismatch");
            } else {
                assertTrue(AssertBytes.equal(out0[i], new bytes(0)), "Output 0 mismatch");
            }
        }
        for (uint256 i = 0; i < out1.length; i++) {
            if (i < in1.length) { 
                assertTrue(AssertBytes.equal(out1[i], in1[i]), "Output 1 mismatch");
            } else {
                assertTrue(AssertBytes.equal(out1[i], new bytes(0)), "Output 1 mismatch");
            }
        }
    }

    function testRLPEncoderBytesArrayBytesArrayBytesArray(bytes[] memory in0, bytes[] memory in1, bytes[] memory in2) public {
        bytes memory buf = RLPEncoderHelper.encodeAndDecode(abi.encode(in0, in1, in2), 0);

        (bytes[] memory out0, bytes[] memory out1, bytes[] memory out2) = abi.decode(buf, (bytes[], bytes[], bytes[]));
        for (uint256 i = 0; i < out0.length; i++) {
            if (i < in0.length) {
                assertTrue(AssertBytes.equal(out0[i], in0[i]), "Output 0 mismatch");
            } else {
                assertTrue(AssertBytes.equal(out0[i], new bytes(0)), "Output 0 mismatch");
            }
        }
        for (uint256 i = 0; i < out1.length; i++) {
            if (i < in1.length) { 
                assertTrue(AssertBytes.equal(out1[i], in1[i]), "Output 1 mismatch");
            } else {
                assertTrue(AssertBytes.equal(out1[i], new bytes(0)), "Output 1 mismatch");
            }
        }
        for (uint256 i = 0; i < out2.length; i++) {
            if (i < in2.length) { 
                assertTrue(AssertBytes.equal(out2[i], in2[i]), "Output 2 mismatch");
            } else {
                assertTrue(AssertBytes.equal(out2[i], new bytes(0)), "Output 2 mismatch");
            }
        }
    }

    function testRLPEncoderBytesArrayBytesBytes(bytes[] memory in0, bytes memory in1, bytes memory in2) public {
        bytes memory buf = RLPEncoderHelper.encodeAndDecode(abi.encode(in0, in1, in2), 0);

        (bytes[] memory out0, bytes memory out1, bytes memory out2) = abi.decode(buf, (bytes[], bytes, bytes));
        for (uint256 i = 0; i < out0.length; i++) {
            if (i < in0.length) {
                assertTrue(AssertBytes.equal(out0[i], in0[i]), "Output 0 mismatch");
            } else {
                assertTrue(AssertBytes.equal(out0[i], new bytes(0)), "Output 0 mismatch");
            }
        }
        assertTrue(AssertBytes.equal(out1, in1), "Output 1 mismatch");
        assertTrue(AssertBytes.equal(out2, in2), "Output 2 mismatch");
    }

    function testRLPEncoderBytesArrayBytesArrayBytes(bytes[] calldata in0, bytes[] calldata in1, bytes memory in2) public {
        bytes memory buf = RLPEncoderHelper.encodeAndDecode(abi.encode(in0, in1, in2), 0);

        (bytes[] memory out0, bytes[] memory out1, bytes memory out2) = abi.decode(buf, (bytes[], bytes[], bytes));
        for (uint256 i = 0; i < out0.length; i++) {
            if(i < in0.length){ 
                assertTrue(AssertBytes.equal(out0[i], in0[i]), "Output 0 mismatch");
            } else {
                assertTrue(AssertBytes.equal(out0[i], new bytes(0)), "Output 0 mismatch");
            }
        }
        for (uint256 i = 0; i < out1.length; i++) {
            if(i < in1.length){
                assertTrue(AssertBytes.equal(out1[i], in1[i]), "Output 1 mismatch");
            } else {
                assertTrue(AssertBytes.equal(out1[i], new bytes(0)), "Output 1 mismatch");
            }
        }
        assertTrue(AssertBytes.equal(out2, in2), "Output 2 mismatch");
    }
}
