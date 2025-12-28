#!/bin/bash

# Load environment variables
if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
else
    echo ".env file not found."
    exit 1
fi

# Check for required variables
if [ -z "$ALCHEMY_API_KEY" ]; then
    echo "Error: ALCHEMY_API_KEY is not set in .env"
    echo "Make sure your .env has ALCHEMY_API_KEY=your_key_here"
    exit 1
fi

# Select network
NETWORK=${1:-sepolia}

if [ "$NETWORK" == "sepolia" ]; then
    RPC_URL="https://eth-sepolia.g.alchemy.com/v2/${ALCHEMY_API_KEY}"
elif [ "$NETWORK" == "polygon" ]; then
    RPC_URL="https://polygon-mainnet.g.alchemy.com/v2/${ALCHEMY_API_KEY}"
else
    echo "Unknown network: $NETWORK. Use 'sepolia' or 'polygon'."
    exit 1
fi

echo "Using Alchemy API Key: ${ALCHEMY_API_KEY:0:5}***"
echo "Deploying MeowNFT to $NETWORK..."

forge script script/DeployMeow.s.sol:DeployMeow \
    --rpc-url $RPC_URL \
    --broadcast \
    --verify \
    -vvvv
