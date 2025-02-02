// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {script, console2} from "forge-std/script.sol";
import {AiAGentToken} from "../src/AiAgentToken.sol";

    // forge script \
    // script/DeployToken.sol:DeployTokenScript \
    // --rpc-url https://optimism-sepolia.core.chainstack.com/a2b735c69e8c07e89959ffa7a1247d0d \
    //  --broadcast -s \
    //  deploy


import {Script, console2} from "forge-std/Script.sol";
import {AiAGentToken} from "../src/AiAgentToken.sol";

contract DeployTokenScript is Script {
    uint256 privKey;
    address keyAddr;
    address tokenAddress;

    function setUp() public {}

    function deploy() public {
        privKey = vm.envUint("PRIVATE_KEY");
        keyAddr = vm.addr(privKey);
        
        console2.log("Account address: ", keyAddr);

        // Start broadcasting transactions
        vm.startBroadcast(privKey);

        // Deploy the AiAGentToken contract
        AiAGentToken tokenContract = new AiAGentToken(keyAddr);
        tokenAddress = address(tokenContract);

        // Stop broadcasting transactions
        vm.stopBroadcast();

        console2.log("Token deployed at: ", tokenAddress);
    }
}
