// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/MeowNFT.sol";

contract MeowNFTTest is Test {
    MeowNFT public meow;
    address public owner = address(1);
    address public recipient = address(2);

    function setUp() public {
        vm.prank(owner);
        meow = new MeowNFT(owner);
    }

    function test_Mint() public {
        string memory name = "Test Meow";
        string memory desc = "This is a test";
        string memory url = "ipfs://QmTest";

        uint256 tokenId = meow.mint(recipient, name, desc, url);

        assertEq(meow.balanceOf(recipient), 1);
        assertEq(meow.ownerOf(tokenId), recipient);
        
        string memory tokenUri = meow.tokenURI(tokenId);
        assertTrue(bytes(tokenUri).length > 0);
        // data:application/json;base64,... で始まることを確認
        assertEq(substring(tokenUri, 0, 29), "data:application/json;base64,");
    }

    function test_Burn() public {
        uint256 tokenId = meow.mint(recipient, "BurnMe", "Desc", "url");
        
        vm.prank(recipient);
        meow.burn(tokenId);

        assertEq(meow.balanceOf(recipient), 0);
    }

    // Helper to check prefix
    function substring(string memory str, uint startIndex, uint endIndex) internal pure returns (string memory) {
        bytes memory strBytes = bytes(str);
        bytes memory result = new bytes(endIndex - startIndex);
        for (uint i = startIndex; i < endIndex; i++) {
            result[i - startIndex] = strBytes[i];
        }
        return string(result);
    }
}
