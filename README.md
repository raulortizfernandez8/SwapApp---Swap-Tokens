# SwapApp---Swap-Tokens
A minimal Solidity smart contract that allows users to swap ERC20 tokens through a Uniswap V2-compatible router (tested on Arbitrum). The project also includes Foundry-based tests that simulate real token swaps.
# 🔹 Contract Overview

The SwapApp contract provides a simple interface for token swaps. Its main features are:

Router integration

The contract stores the address of a Uniswap V2 router (addressV2Router02) provided at deployment.

All swap operations are routed through this address.

Token transfer and approval

When a user calls the swap function, the contract first transfers the input token from the user to itself.

It then approves the router to spend those tokens on behalf of the contract.

Swap execution

Uses the swapExactTokensForTokens function from the V2 router.

Tokens are swapped following a path specified by the user (e.g., USDT → DAI).

The resulting tokens are sent directly to the caller’s address.

Event emission

After every swap, the contract emits a SwapTokens event containing:

Input token

Output token

Input amount

Final output amount

# 🔹 Testing with Foundry

The project includes tests that fork Arbitrum mainnet to simulate real swaps. Key points:

Deployment test

Verifies that the contract is initialized with the correct router address.

Swap test

Impersonates a real account funded with USDT on Arbitrum.

Approves the contract to spend USDT.

Executes a swap from USDT (6 decimals) to DAI (18 decimals).

Checks that:

The user’s USDT balance decreases by the input amount.

The user’s DAI balance increases after the swap.

# 🔹 How to Run the Tests

Requirements:

Foundry
 installed.

An Arbitrum RPC endpoint.

Run the tests with:

forge test -vvvv \
  --fork-url https://arb1.arbitrum.io/rpc \
  --match-test testSwapToken


-vvvv: detailed logs

--fork-url: forks Arbitrum mainnet for testing with real liquidity

--match-test: runs only the swap test

# 📌 Key Characteristics

- Simplicity: Designed as a minimal wrapper for Uniswap V2 swaps.

- Flexibility: Users define the swap path, minimum output, and deadline.

- Security: Uses OpenZeppelin’s SafeERC20 for safe token transfers.

- Transparency: Emits an event with swap details for monitoring.
