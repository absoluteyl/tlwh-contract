# the Last Watch Hist Contract

## Prerequisites

- solidity ^0.8.0
- foundry ^0.2.0

## Development

### Clone this project from Github

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

## Specifications

### Proxy Pattern

tLWH uses UUPS Proxy Pattern

```mermaid
flowchart LR
  Proxy -- Current --> TokenV1
  Proxy -. In the future.-> TokenV2
```

### Soul-bound NFT

tLWH token is designed to be a soul-bound NFT collection, so:

1. Only one tLWH NFT is allowed to mint per EOA address.
2. tLWH NFT cannot be transferred to another address.

### NFT Metadata

tLWH token's metadata is stored in IPFS, and the IPFS CID is stored in the contract as tokenURI. The metadata is a JSON file with the following structure:

```json
{
  "id": "$TOKEN_ID",
  "name": "The Last Watch Hist #$TOKEN_ID",
  "owner": "$OWNER_ADDRESS",
  "image": "ipfs://$IPFS_ID_OF_IMAGE",
}

// example
{
  "id": "1",
  "name": "The Last Watch Hist #1",
  "owner": "0x6CA6d1e2D5347Bfab1d91e883F1915560e09129D",
  "image": "ipfs://QmNmfAqjiQgdLJscpM3FufbaXY9QEqWZiWqDTbsrUjSKDR",
}
```
