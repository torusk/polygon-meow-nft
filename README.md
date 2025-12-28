# Polygon Meow NFT Project 🐱🏆

Sui Testnet版で展開していた「Meow NFT Project」をベースに、Polygon (EVM) 環境へ完全移植したNFTプロジェクトです。
開発フレームワークに **Foundry** を採用し、高度なセキュリティとガス効率、そして柔軟なオンチェーンメタデータ方式を実現しています。

## 🌟 プロジェクトのハイライト

- **完全オンチェーンメタデータ**: JSONデータをブロックチェーン上で動的に生成。外部サーバーやストレージ（IPFS以外）に依存しない、永続性の高いNFTです。
- **Foundryによる堅牢な開発**: 業界標準のツールチェーンを使用し、デプロイから検証までのワークフローを自動化しています。
- **シームレスな配布システム**: シェルスクリプト (`distribute.sh`) により、複雑なコマンドを打つことなく、誰でも簡単に特定の画像やメッセージを込めたNFTを配布可能です。
- **マルチネットワーク対応**: Ethereum Sepolia (テスト用) と Polygon Mainnet (本番用) の両方に即時対応しています。

## 📁 主要ファイル構成

| ディレクトリ / ファイル | 役割 |
| :--- | :--- |
| `src/MeowNFT.sol` | **スマートコントラクト**: ERC721準拠。オンチェーンでメタデータを結合・生成します。 |
| `script/DeployMeow.s.sol` | **デプロイ・スクリプト**: FoundryのSolidityスクリプトを用いたプロフェッショナルなデプロイ処理。 |
| `deploy.sh` | **デプロイ実行ラッパー**: ネットワーク指定だけで簡単にデプロイを行うためのフロントエンドです。 |
| `distribute.sh` | **NFT配布メインスクリプト**: 受取人アドレスを指定するだけで、デフォルト設定のNFTを即座に発行・送信します。 |
| `mint.sh` | **内部ミント処理**: `distribute.sh`から呼び出され、Foundryの`cast`コマンドを用いてトランザクションを実行します。 |
| `DEPLOYED_ADDRESSES.md` | **アドレス管理台帳**: デプロイされた各ネットワークの最新コントラクトアドレスを記録します。 |

> [!NOTE]
> **NFT Viewer について**:
> 以前同梱されていたビューアー (`index.html`) は、現在 [NFT Viewer リポジトリ](https://github.com/torusk/meow-viewer) へ移動し、独立したWebプロジェクトとして進化しました。

## 🚀 クイックスタートガイド

### 1. 環境構築
まずは環境変数の準備を行います。`.env` ファイルを作成し、必要な情報を記入してください。

```bash
cp config.env.sample .env
# エディタで開き、PRIVATE_KEY=0x... と ALCHEMY_API_KEY=... を設定
```

### 2. コントラクトのデプロイ
新しい「NFT工場」をブロックチェーン上に設置します。

```bash
# テストネット (Sepolia) の場合
./deploy.sh sepolia

# 本番 (Polygon Mainnet) の場合
./deploy.sh polygon
```
実行後、ターミナルに表示される `Contract Address` を `DEPLOYED_ADDRESSES.md` に追記してください。

### 3. NFTの配布（ミント）
デプロイしたコントラクトを使用して、友人やチームメンバーにNFTを贈ります。

```bash
# ./distribute.sh [受取人アドレス] [ネットワーク(任意)]
./distribute.sh 0x742d... sepolia
```
※ 画像や説明文をカスタマイズしたい場合は、`distribute.sh` 冒頭の `DEFAULT_NAME` 等を直接編集してください。

## ⚖️ コストの目安 (Polygon Mainnet)

Polygon ネットワークは非常に安価で、1トランザクション数円〜数十円で運用可能です。（下記は目安）

| アクション | 推定コスト | 目的 |
| :--- | :--- | :--- |
| **コントラクトデプロイ** | 1.0 〜 3.0 POL | プロジェクトの初期立ち上げ |
| **NFT 1枚の配布** | 0.05 〜 0.15 POL | メンバーへの記念品贈呈 |

---
*Created by torusk | Assisted by Antigravity*
