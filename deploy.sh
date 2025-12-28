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

# デプロイ実行とアドレスの抽出
OUTPUT=$(forge script script/DeployMeow.s.sol:DeployMeow \
    --rpc-url $RPC_URL \
    --broadcast \
    --verify \
    -vvvv)

echo "$OUTPUT"

# コントラクトアドレスをログから抽出 (Deployed to: 0x... または Contract Address: 0x...)
CONTRACT_ADDRESS=$(echo "$OUTPUT" | grep -E "Deployed to:|Contract Address:|deployed to:" | grep -oE "0x[a-fA-F0-9]{40}" | head -n 1)

if [ -n "$CONTRACT_ADDRESS" ]; then
    echo "--------------------------------------------------"
    echo "🚀 デプロイが完了しました！"
    echo "Contract Address: $CONTRACT_ADDRESS"
    echo "--------------------------------------------------"

    # DEPLOYED_ADDRESSES.md への自動記録
    DATE=$(date +%Y-%m-%d)
    if [ "$NETWORK" == "polygon" ]; then
        sed -i '' "s/- \*\*Latest Address\*\*: (未デプロイ)/- **Latest Address**: \`$CONTRACT_ADDRESS\` (Updated: $DATE)/" DEPLOYED_ADDRESSES.md
    else
        sed -i '' "s/- \*\*Latest Address\*\*: 0x.*/- **Latest Address**: \`$CONTRACT_ADDRESS\` (Updated: $DATE)/" DEPLOYED_ADDRESSES.md
    fi
    echo "📝 DEPLOYED_ADDRESSES.md にアドレスを自動記録しました。"
else
    echo "❌ デプロイに失敗したか、アドレスの抽出に失敗しました。"
    exit 1
fi
