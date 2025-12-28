#!/bin/bash

# デフォルト設定（Sui版と同じ内容）
DEFAULT_NAME="Champion 2025 Meow Chain "
DEFAULT_DESC="Commemorating the victory of Team \"Meow Chain\" at The University of Tokyo Blockchain Innovation Endowed Chair 2025 Group Work Competition. This NFT is independently issued by the team members to honor our collaboration and First Prize achievement."
DEFAULT_IMAGE="ipfs://bafkreid3y76ejdkbj2nxsjc6wpd6sg6bjzyjk5cmz6ae57lixbqygafdse"

# Load environment variables
if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
else
    echo ".env file not found."
    exit 1
fi

CONTRACT_ADDRESS=$1
RECIPIENT_ADDRESS=$2
NETWORK=${3:-sepolia}

if [ -z "$CONTRACT_ADDRESS" ] || [ -z "$RECIPIENT_ADDRESS" ]; then
    echo "Usage: ./distribute.sh <CONTRACT_ADDRESS> <RECIPIENT_ADDRESS> [NETWORK]"
    exit 1
fi

./mint.sh "$CONTRACT_ADDRESS" "$RECIPIENT_ADDRESS" "$DEFAULT_NAME" "$DEFAULT_DESC" "$DEFAULT_IMAGE" "$NETWORK"
