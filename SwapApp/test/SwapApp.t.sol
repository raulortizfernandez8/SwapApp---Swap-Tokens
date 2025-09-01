//SPDX-License-Identifier: MIT
// Forge test -vvvv --fork-url https://arb1.arbitrum.io/rpc --match-test nombredelafuncionparatestear
pragma solidity 0.8.28;

import "../lib/forge-std/src/Test.sol";
import "../src/SwapApp.sol";

contract SwapAppTest is Test{

    SwapApp swapapp;
    address V2Routeraddress_ = 0x4752ba5DBc23f44D87826276BF6Fd6b1C372aD24; // This can be found in Uniswap docs.
    address userWithUSDT = ; // This address contains USDT
    address USDT = 0xFd086bC7CD5C481DCC9C85ebE478A1C0b69FCbb9; // This is the USDT address
    address DAI = 0xDA10009cBd5D07dd0CeCc66161FC93D7c9000da1; // This is the DAI address
    function setUp() public{
        swapapp = new SwapApp(V2Routeraddress_);
    }   
    function testDeployedCorrectly() public view{
        assert(swapapp.addressV2Router02() == V2Routeraddress_);
    }
    function testSwapToken() public{
        vm.startPrank(userWithUSDT);

        uint256 amountIn = 3*1e6; // USDT has 6 decimals
        uint256 amountOutMin = 2*1e18; // DAI has 18 decimals.
        address [] memory path = new address[](2);
        path[0]= USDT;
        path[1]=DAI;
        uint256 deadline = block.timestamp + 10000;

        IERC20(USDT).approve(address(swapapp),amountIn);
        uint256 balanceBeforeUSDT = IERC20(USDT).balanceOf(userWithUSDT);
        uint256 balanceBeforeDAI = IERC20(DAI).balanceOf(userWithUSDT);
        swapapp.swapTokens(amountIn, amountOutMin, path, deadline);
        uint256 balanceAfterUSDT = IERC20(USDT).balanceOf(userWithUSDT);
        uint256 balanceAfterDAI = IERC20(DAI).balanceOf(userWithUSDT);
        assert(balanceBeforeUSDT==balanceAfterUSDT+amountIn);
        assert(balanceAfterDAI>balanceBeforeDAI);
        vm.stopPrank();

    }

}
