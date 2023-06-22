# the Last Watch Hist Contract

## Preqrequisites

- solidity ^0.8.0
- foundry ^0.2.0

## Development

### Clone this project from github

```bash
git clone git@github.com:absoluteyl/tlwh-contract.git
```

### Install dependencies

```bash
forge install
```

### Configure environment variables

copy `.env.example` to `.env` and set the environment variables of your own.

```bash
cp .env.example .env

# reload after configured
cd .
```

### Configure RPC Endpoints

configuration for Alchemy Sepolia endpoint is been set in `foundry.toml`, feel free to modify it.

```toml
[rpc_endpoints]
sepolia = "https://eth-sepolia.g.alchemy.com/v2/${ALCHEMY_ETH_SEPOLIA_KEY}"
```

### Testing

```bash
forge test
```

## Deploy and Verify

### Deploy and verify a new contract

```bash
forge script script/theLastWatchHist.s.sol --rpc-url sepolia --broadcast --verify
```

### Verify existing contract

```bash
forge verify-contract \
--chain-id 11155111 \
--num-of-optimizations 200 \
--watch \
--etherscan-api-key $ETHERSCAN_API_KEY \
--compiler-version v0.8.19+commit.7dd6d404 \
$CONTRACT_ADDRESS \
src/theLastWatchHist.sol:TheLastWatchHist
```

## Contract Specifications

tLWH is designed to be a soul-bound NFT collection, so:

1. Only one tLWH NFT is allowed to mint per EOA address.
2. tLWH NFT cannot be transferred to another address.
