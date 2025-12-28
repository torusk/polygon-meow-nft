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
    exit 1
fi

# Usage: ./mint.sh <CONTRACT_ADDRESS> <RECIPIENT_ADDRESS> <NAME> <DESC> <IMAGE_URL> <NETWORK>
export CONTRACT_ADDRESS=$1
export RECIPIENT_ADDRESS=$2
export NFT_NAME=$3
export NFT_DESC=$4
export IMAGE_URL=$5
NETWORK=${6:-sepolia}

if [ "$NETWORK" == "sepolia" ]; then
    RPC_URL="https://eth-sepolia.g.alchemy.com/v2/${ALCHEMY_API_KEY}"
elif [ "$NETWORK" == "polygon" ]; then
    RPC_URL="https://polygon-mainnet.g.alchemy.com/v2/${ALCHEMY_API_KEY}"
fi

echo "Using Alchemy API Key for minting..."

echo "Minting MeowNFT on $NETWORK..."

forge script script/MintMeow.s.sol:MintMeow \
    --rpc-url $RPC_URL \
    --broadcast \
    -vvvv
