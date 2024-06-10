
// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {ScrollBadge} from "../ScrollBadge.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/// @title ScrollBadgeEligibilityCheck
/// @notice This contract adds a standard on-chain eligibility check API.
abstract contract ScrollBadgeEligibilityCheck is ScrollBadge {
    address public pandaTokenAddress;
    uint256 constant THIRTY_BILLION = 30_000_000_000 * 10**18; // Assuming 18 decimal places for $PANDA

    /// @notice Constructor to set the $PANDA token address
    /// @param pandaTokenAddress_ The address of the $PANDA token contract
    constructor(address pandaTokenAddress_) {
        pandaTokenAddress = pandaTokenAddress_;
    }

    /// @notice Check if user is eligible to mint this badge.
    /// @param recipient The user's wallet address.
    /// @return Whether the user is eligible to mint.
    function isEligible(address recipient) external view virtual override returns (bool) {
        if (hasBadge(recipient)) {
            return false;
        }

        uint256 balance = IERC20(pandaTokenAddress).balanceOf(recipient);
        return balance > THIRTY_BILLION;
    }
}

