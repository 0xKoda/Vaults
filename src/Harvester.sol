// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.10;

import {SafeTransferLib, ERC20} from "solmate/utils/SafeTransferLib.sol";

contract Harvester {
    using SafeTransferLib for ERC20;
    //emit when vault destination is changed
    event RewardDestinationUpdate(address indexed newDestination);

    event ClaimRewards(ERC20 indexed rewardToken, uint256 amount);

    /// @notice the address to send rewards
    address public rewardDestination;

    /// @notice reward token
    ERC20 public rewardToken;

    constructor(address _rewardDestination, ERC20 _rewardToken) {
        rewardDestination = _rewardDestination;
        rewardToken = _rewardToken;
    }

    /// @notice claim outstanding rewards
    function claimRewards() internal {
        uint256 amount = rewardToken.balanceOf(address(this));
        if (amount > 0) {
            rewardToken.transfer(rewardDestination, amount);
            emit ClaimRewards(rewardToken, amount);
        }
    }

    /// @notice set the address of the new reward destination (vault)
    /// @param newDestination the new reward destination (vault)
    function setRewardDestination(address newDestination) external {
        require(msg.sender == rewardDestination, "UNAUTHORIZED");
        rewardDestination = newDestination;
        emit RewardDestinationUpdate(newDestination);
    }

    /// @notice hook to accrue/pull in rewards, if needed
    function beforeClaim() internal virtual {}

    function _transferAll(ERC20 token, address to)
        internal
        returns (uint256 amount)
    {
        token.safeTransfer(to, amount = token.balanceOf(address(this)));
    }
}
