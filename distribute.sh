#!/bin/bash

# デフォルト設定（Sui版と同じ内容）
DEFAULT_NAME="Champion 2025 Meow Chain "
DEFAULT_DESC="Commemorating the victory of Team \"Meow Chain\" at The University of Tokyo Blockchain Innovation Endowed Chair 2025 Group Work Competition. This NFT is independently issued by the team members to honor our collaboration and First Prize achievement."
DEFAULT_IMAGE="ipfs://bafkreicghzl5r5u7mwapzcedavydpts6zcrajh2guhuqaxqjehibd2rouu"

# Load environment variables
if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
else
    echo ".env file not found."
    exit 1
fi

# 引数の処理
RECIPIENT_ADDRESS=$1
NETWORK=${2:-sepolia}

# コントラクトアドレスを DEPLOYED_ADDRESSES.md から自動取得（最新のものを取得）
if [ "$NETWORK" == "polygon" ]; then
    CONTRACT_ADDRESS=$(sed -n '/## 💜 Polygon (Mainnet)/,/---/p' DEPLOYED_ADDRESSES.md | grep -o '0x[a-fA-F0-9]\{40\}' | tail -n 1)
else
    CONTRACT_ADDRESS=$(sed -n '/## 🧪 Sepolia (Testnet)/,/## 💜 Polygon (Mainnet)/p' DEPLOYED_ADDRESSES.md | grep -o '0x[a-fA-F0-9]\{40\}' | tail -n 1)
fi

# チェック
if [ -z "$CONTRACT_ADDRESS" ]; then
    echo "❌ エラー: DEPLOYED_ADDRESSES.md から最新のアドレスを取得できませんでした。"
    echo "先に ./deploy.sh $NETWORK を実行してください。"
    exit 1
fi

if [ -z "$RECIPIENT_ADDRESS" ]; then
    echo "使用法: ./distribute.sh [宛先アドレス] [ネットワーク(任意: デフォルトsepolia)]"
    exit 1
fi

echo "📍 最新のコントラクトを使用します: $CONTRACT_ADDRESS"
./mint.sh "$CONTRACT_ADDRESS" "$RECIPIENT_ADDRESS" "$DEFAULT_NAME" "$DEFAULT_DESC" "$DEFAULT_IMAGE" "$NETWORK"

echo "--------------------------------------------------"
echo "🚀 ミントが完了しました！"
echo ""
echo "以下の情報を NFT Viewer で入力して確認してください："
echo "--------------------------------------------------"
echo "【Contract Address】 : $CONTRACT_ADDRESS"
echo "【Token ID】         : （上のログの 'Minted NFT with ID: X' の数字を見てください）"
echo "--------------------------------------------------"
echo "🌐 別プロジェクトの 'NFT Viewer' を起動し、上記を入力して内容を確認してください。"



