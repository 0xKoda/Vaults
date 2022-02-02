pragma solidity ^0.8.10;

import {ERC20} from "solmate/tokens/ERC20.sol";
import {ERC4626} from "solmate/mixins/ERC4626.sol";
import {RewardsClaimer} from "./RewardsClaimer.sol";

abstract contract vaultERC4626 is ERC4626, RewardsClaimer {
    mapping(address => uint256) balances;

    ERC20 public immutable UNDERLYING;

    constructor(ERC20 underlying) ERC4626(underlying, "Vault", "V") {
        UNDERLYING = ERC20(underlying);
    }

    function totalAssets() public view override returns (uint256) {
        return asset.balanceOf(address(this));
    }

    function afterDeposit(uint256 amount) internal override {
        //logic to distribute funds to pools
    }

    function beforeWithdraw(uint256 amount) internal override {
        //logic to distribute funds to pools
        claimRewards();
        if (UNDERLYING.balanceOf(address(this)) < amount)
            _transferAll(UNDERLYING, address(this));
    }
}
