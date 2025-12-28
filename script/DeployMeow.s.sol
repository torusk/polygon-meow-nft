// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/MeowNFT.sol";

contract DeployMeow is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployerAddress = vm.envAddress("PUBLIC_KEY");

        vm.startBroadcast(deployerPrivateKey);

        MeowNFT meow = new MeowNFT(deployerAddress);
        
        console.log("MeowNFT deployed to:", address(meow));

        vm.stopBroadcast();
    }
}
