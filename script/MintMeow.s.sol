// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/MeowNFT.sol";

contract MintMeow is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address contractAddress = vm.envAddress("CONTRACT_ADDRESS");
        address recipient = vm.envAddress("RECIPIENT_ADDRESS");
        
        string memory name = vm.envString("NFT_NAME");
        string memory description = vm.envString("NFT_DESC");
        string memory imageURL = vm.envString("IMAGE_URL");

        vm.startBroadcast(deployerPrivateKey);

        MeowNFT meow = MeowNFT(contractAddress);
        uint256 tokenId = meow.mint(recipient, name, description, imageURL);
        
        console.log("Minted NFT with ID:", tokenId);
        console.log("Recipient:", recipient);

        vm.stopBroadcast();
    }
}
