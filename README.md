# Chatbotto Ruby Application

This project is a rule-based chatbot application built with Nextjs and Ruby. It uses pgroonga for full-text search and mecab for Japanese language tokenization. The chatbot produces suggestions based on the user's input and answers questions directly from the qa table data.

## Alternative versions

- [Chatbotto Nextjs Node Application](https://github.com/Sherbieny/chatbotto)
- [Chatbotto Browser Application](https://github.com/Sherbieny/chatbotto_browser)
- [Chatbotto Lumen Application](https://github.com/Sherbieny/chatbotto_lumen)

## Features

- Rule-based chatbot
- Full-text search
- Japanese language tokenization
- Dockerized development environment
- Nextjs frontend and admin dashboard for managing the chatbot settings and uploading the qa table data
- Ruby backend API
- Ruby console commands to import and index qa table data
- Sample qa table data json files for import extracted from JaQuad dataset
- Images and icons are generated by ChatGPT DALL-E

## Installation

1. Clone the repository

2. Run the following commands in project root to build and start the docker containers

```bash
docker-compose up -d --build
```

3. SSH into the `back` container and run the following commands to install existing qa data (optional)

   a. Import qa table data

   ```bash
    rails runner 'ImportQaDataJob.perform_now'
   ```

   b. Index the qa table data

   ```bash
    rails runner 'IndexQaDataJob.perform_now'
   ```

## Configuration

1. In front directory rename the .env.local.tmp to .env.local and update the following environment variables

   a. `NEXT_PUBLIC_API_URL` - set to `http://localhost:3001 for development and `https://yourdomain.com` for production

## API Endpoints

```bash
# Get suggestions based on the user's input
GET /api/suggestions
# Parameters: query (string)

# Send a message to the chatbot
POST /api/message
# Parameters: query (string)

# Get the chatbot settings
GET /api/settings

# Update the chatbot settings
POST /api/settings
# Parameters: settings (object)

# Upload the qa table data
POST /api/upload
# Parameters: file (file)

# Process the qa table data (import and index)
POST /api/process

```

## Usage

1. Start the docker containers

```bash
docker-compose start
```

2. Open the browser and navigate to `http://localhost:3000` to access the chatbot application

3. start typing to interact with the chatbot, select from the suggestions or ask a question directly

4. Click on the gear icon to access the admin dashboard

5. Use the admin dashboard to manage the chatbot settings and upload the qa table data
   a. On qa data upload, the job will execute the rails console command to import and index the qa table data.

## Tools and Technologies

- [Nextjs](https://nextjs.org/)
- [Ruby](https://www.ruby-lang.org/en/)
- [Rails](https://rubyonrails.org/)
- [pgroonga](https://pgroonga.github.io/)
- [mecab](https://taku910.github.io/mecab/)
- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)
- [PopstgreSQL](https://www.postgresql.org/)
- [VS Code](https://code.visualstudio.com/)
- [Github Copilot](https://copilot.github.com/)
- [Github Copilot Chat](https://marketplace.visualstudio.com/items?itemName=GitHub.copilot-chat)

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License

[GLP-3.0](https://www.gnu.org/licenses/gpl-3.0.html)

# チャットボット Ruby アプリケーション

このプロジェクトは、Nextjs と Ruby を使用して構築されたルールベースのチャットボットアプリケーションです。pgroonga を使用して全文検索を行い、mecab を使用して日本語のトークン化を行います。チャットボットは、ユーザーの入力に基づいて提案を生成し、qa テーブルデータから直接質問に答えます。

## 代替バージョン

- [Chatbotto Nextjs Node Application](https://github.com/Sherbieny/chatbotto)
- [Chatbotto Browser Application](https://github.com/Sherbieny/chatbotto_browser)
- [Chatbotto Lumen Application](https://github.com/Sherbieny/chatbotto_lumen)

## 特徴

- ルールベースのチャットボット
- 全文検索
- 日本語のトークン化
- Docker 化された開発環境
- Nextjs フロントエンドと管理ダッシュボード
- Ruby バックエンド API
- Ruby コンソールコマンドを使用して qa テーブルデータをインポートおよびインデックスするための Ruby コンソールコマンド
- JaQuad データセットから抽出されたインポート用のサンプル qa テーブルデータ json ファイル
- ChatGPT DALL-E によって生成された画像とアイコン

## インストール

1. リポジトリをクローンします
2. プロジェクトのルートで次のコマンドを実行して、Docker コンテナをビルドして起動します

```bash
docker-compose up -d --build
```

3. `back` コンテナに SSH して、既存の qa データをインストールします（オプション）

   a. qa テーブルデータをインポートします

   ```bash
    rails runner 'ImportQaDataJob.perform_now'
   ```

   b. qa テーブルデータをインデックスします

   ```bash
    rails runner 'IndexQaDataJob.perform_now'
   ```

## 設定

1. front ディレクトリで .env.local.tmp を .env.local に名前を変更し、次の環境変数を更新します

   a. `NEXT_PUBLIC_API_URL` - 開発用に `http://localhost:3001` に設定し、本番用に `https://yourdomain.com` に設定します

## API エンドポイント

```bash
# ユーザーの入力に基づいて提案を取得します
GET /api/suggestions
# パラメータ: query (string)

# チャットボットにメッセージを送信します
POST /api/message
# パラメータ: query (string)

# チャットボットの設定を取得します
GET /api/settings

# チャットボットの設定を更新します
POST /api/settings
# パラメータ: settings (object)

# qa テーブルデータをアップロードします
POST /api/upload
# パラメータ: file (file)

# qa テーブルデータを処理します（インポートおよびインデックス）
POST /api/process

```

## 使い方

1. Docker コンテナを起動します

```bash
docker-compose start
```

2. ブラウザを開いて、`http://localhost:3000` に移動して、チャットボットアプリケーションにアクセスします

3. タイプを開始して、チャットボットと対話し、提案から選択するか、直接質問をするかを選択します

4. 歯車アイコンをクリックして、管理ダッシュボードにアクセスします

5. 管理ダッシュボードを使用して、チャットボットの設定を管理し、qa テーブルデータをアップロードします
   a. qa データのアップロード時、ジョブは qa テーブルデータをインポートおよびインデックスするための rails コンソールコマンドを実行します。

## ツールとテクノロジー

- [Nextjs](https://nextjs.org/)
- [Ruby](https://www.ruby-lang.org/en/)
- [Rails](https://rubyonrails.org/)
- [pgroonga](https://pgroonga.github.io/)
- [mecab](https://taku910.github.io/mecab/)
- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)
- [PopstgreSQL](https://www.postgresql.org/)
- [VS Code](https://code.visualstudio.com/)
- [Github Copilot](https://copilot.github.com/)
- [Github Copilot Chat](https://marketplace.visualstudio.com/items?itemName=GitHub.copilot-chat)

## 貢献

プルリクエストは歓迎です。重大な変更を行う場合は、まず問題を開いて議論してください。

## ライセンス

[GLP-3.0](https://www.gnu.org/licenses/gpl-3.0.html)

---
