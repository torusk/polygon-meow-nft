# Polygon Meow NFT Project 🐱💜 (Foundry Edition)

Sui版「Meow NFT Project」の魂を受け継いだ、Polygon/Sepolia対応のNFTプロジェクトです。
Foundryを使用して、高速かつ安全にNFTを発行・管理できます。

## 🌟 特徴
- **オンチェーンメタデータ**: JSONをオンチェーンで生成するため、画像URLさえあればミント可能。
- **Foundry採用**: 高速なコンパイルと堅牢なスクリプト設計。
- **Sui互換の思想**: シンプルなミント関数と構造。

## 📁 構成
- **`src/MeowNFT.sol`**: スマートコントラクト (ERC721)
- **`script/`**: デプロイ・ミント用のFoundryスクリプト
- **`deploy.sh`**: 【一撃】デプロイ用スクリプト
- **`mint.sh`**: 【一撃】ミント用スクリプト

## 🚀 はじめかた

### 1. 環境設定
`.env` ファイルを作成し、秘密鍵を設定してください。
```bash
cp config.env.sample .env
```
その後、`.env` を開き、以下の項目を入力します：
- `PRIVATE_KEY`: あなたのメタマスクの秘密鍵 (0x...)

### 2. コントラクトのデプロイ
Sepoliaテストネットにデプロイします。
```bash
./deploy.sh sepolia
```
成功すると、ターミナルに `MeowNFT deployed to: 0x...` と表示されます。このアドレスをメモしてください。

### 3. NFTのミント (発行)
取得したコントラクトアドレスを使って、NFTを発行します。
```bash
./mint.sh [CONTRACT_ADDR] [RECIPIENT_ADDR] "Meow Title" "Meow Description" "ipfs://CID" sepolia
```
※ 引数の最後に `polygon` を指定すると、Polygonメインネットで実行されます（要MATIC）。

## 🛠 便利なコマンド

| 操作 | コマンド |
| :--- | :--- |
| **ビルド** | `forge build` |
| **テスト** | `forge test` |
| **コントラクト検証** | `forge verify-contract [ADDR] MeowNFT --rpc-url [URL]` |

## 📍 ネットワーク情報
- **Sepolia**: テスト用。
- **Polygon**: 本番用。

---
*Created by Antigravity for Kazuki's local project.*
