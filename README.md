# Polygon Meow NFT Project 🐱🏆

Sui Testnet版の「Meow NFT Project」をベースに、Polygon (EVM) 環境へ移植したNFTプロジェクトです。
Foundryを開発フレームワークに採用し、オンチェーンメタデータ方式によって画像URLと説明文をブロックチェーンに直接刻印します。

## 🌟 プロジェクトの要点
- **オンチェーンメタデータ**: JSONデータをブロックチェーン内部で生成するため、外部のメタデータサーバーが不要。
- **Sui互換の設計**: Sui版と同様、誰でもミント（発行）ができ、画像・名前・説明文を自由に指定可能。
- **豪華なビューアー**: 数値を読み取るだけでなく、ブラウザで美しくNFTを確認できる専用ビューアーを同梱。
- **セキュリティ**: 秘密鍵や環境変数は `.env` で管理し、GitHubには公開されない設定になっています。

## 📁 主要ファイルの説明

| ファイル名 | 役割 |
| :--- | :--- |
| `src/MeowNFT.sol` | NFTの本体（スマートコントラクト）。ERC721準拠。 |
| `deploy.sh` | コントラクトを新規デプロイし、ブロックチェーン上に「工場」を建てるためのスクリプト。 |
| `distribute.sh` | 指定した画像・説明文でNFTをミント（配布）するためのメインスクリプト。 |
| `mint.sh` | `distribute.sh` から呼び出されるミント用の内部処理スクリプト。 |
| `index.html` | ミントしたNFTをブラウザで美しく表示・確認するための汎用ビューアー。 |
| `DEPLOYED_ADDRESSES.md` | デプロイ済みのコントラクトアドレスを記録する管理帳。 |
| `.env` | 秘密鍵（PRIVATE_KEY）やAPIキーを保存する設定ファイル（GitHub非公開）。 |

## 🚀 使い方ガイド

### 1. 準備
- `.env` ファイルを作成し、メタマスクの秘密鍵を設定します。
```bash
cp config.env.sample .env
# 秘密鍵を PRIVATE_KEY=0x... の形式で記入
```

### 2. デプロイ（工場の設置）
最新のプログラムをブロックチェーンに公開します。
```bash
./deploy.sh sepolia
```
実行後、表示される `Contract Address` を `DEPLOYED_ADDRESSES.md` にメモします。

### 3. ミント（NFTの発行・配布）
お好みの画像（IPFS）を設定してNFTを発行します。
1. `distribute.sh` を開き、冒頭の `DEFAULT_NAME` や `DEFAULT_IMAGE` を書き換える。
2. 以下のコマンドを実行（コントラクトアドレスは自動取得されます）：
```bash
# ./distribute.sh [受取人のアドレス] [ネットワーク(任意)]
./distribute.sh 0x3909... sepolia
```

### 4. 確認（ビューアー）
1. `index.html` をブラウザで開きます。
2. ミント完了時に表示された **Contract Address** と **Token ID** を入力します。
3. 「データを読み込む」を押すと、あなたのNFTが「いい感じ」に表示されます！


## 💰 費用について (Polygon Mainnet)

Polygonメインネットでの運用コストは非常に低く抑えられます。以下は2025年時点の目安です。

| 操作 | 概算費用 (JPY) | 概算費用 (MATIC/POL) | 備考 |
| :--- | :--- | :--- | :--- |
| **デプロイ (初回のみ)** | 約 100円 ~ 250円 | 1 ~ 3 MATIC | スマートコントラクト（工場）の設置 |
| **ミント (1枚あたり)** | 約 2円 ~ 15円 | 0.05 ~ 0.1 MATIC | NFTを1枚発行・配布 |

*※ 1ドル=150円、1MATIC=60円程度のレートを基準にした2025年時点の目安です。ネットワークの混雑状況により前後します。*

## 💜 本番 (Polygon) への移行
1. 自分のウォレットに少額の $MATIC (または $POL) を用意します。
2. `deploy.sh` と `distribute.sh` のネットワーク引数を `polygon` に変えて実行するだけです。
   ```bash
   ./deploy.sh polygon
   ./distribute.sh [宛先アドレス] polygon
   ```


---
*Created by torusk with Katana/Antigravity assistance.*
