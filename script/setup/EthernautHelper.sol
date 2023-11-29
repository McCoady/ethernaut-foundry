// SPDX-License-Identifier: MIT
pragma solidity 0.8.21;

import {Script, console2} from "forge-std/Script.sol";
import {IEthernaut} from "./IEthernaut.sol";
import "forge-std/Test.sol";

contract EthernautHelper is Script {
    address constant HERO = address(0); // NOTE CHANGE THIS TO YOUR ADDRESS
    address constant ETHERNAUT = 0xa3e7317E591D5A0F1c605be1b3aC4D2ae56104d6;

    function createInstance(
        address levelAddress
    ) public returns (address challengeInstance) {
        vm.recordLogs();
        IEthernaut(ETHERNAUT).createLevelInstance(levelAddress);
        Vm.Log[] memory createEntries = vm.getRecordedLogs();
        // This is the instance of the challenge contract you need to work with.
        challengeInstance = address(
            uint160(uint256(createEntries[0].topics[2]))
        );
    }

    function submitInstance(address challengeInstance) public returns(bool) {
        vm.recordLogs();
        IEthernaut(ETHERNAUT).submitLevelInstance(payable(challengeInstance));
        Vm.Log[] memory submitEntries = vm.getRecordedLogs();
        if (submitEntries.length == 0) {
            return false;
        } else {
            return true;
        }
    }
}
