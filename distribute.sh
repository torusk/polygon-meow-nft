#!/bin/bash

# デフォルト設定（Sui版と同じ内容）
DEFAULT_NAME="Champion 2025 Meow Chain "
DEFAULT_DESC="Commemorating the victory of Team \"Meow Chain\" at The University of Tokyo Blockchain Innovation Endowed Chair 2025 Group Work Competition. This NFT is independently issued by the team members to honor our collaboration and First Prize achievement."
DEFAULT_IMAGE="ipfs://bafkreia6x5a4he3lsr5agkzmtzwbydig4qriefh4xcivo2h2vjaft2d6oe"

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

echo "--------------------------------------------------"
echo "🚀 ミントが完了しました！"
echo ""
echo "以下の情報を index.html に入力して確認してください："
echo "--------------------------------------------------"
echo "【Contract Address】: $CONTRACT_ADDRESS"
echo "【Token ID】       : （上のログの 'Minted NFT with ID: X' の数字を見てください）"
echo "--------------------------------------------------"
echo "🌐 ブラウザで index.html を開き、上記を入力して「データを読み込む」をクリック！"



