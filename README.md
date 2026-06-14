# Cloud Resume Challenge

AWS 上に自身の履歴書（レジュメ）サイトを構築する学習プロジェクト [Cloud Resume Challenge](https://cloudresumechallenge.dev/) の実装リポジトリです。

## プロジェクト概要

Cloud Resume Challenge は、Forrest Brazeal 氏が提唱したクラウド学習者向けの実践課題です。「HTML/CSS で履歴書を書く」「クラウド上で配信する」「訪問者カウンターを実装する」「IaC と CI/CD で運用する」といった一連の要件を満たすことで、クラウドエンジニアとして必要な基礎スキルを横断的に習得することを目的としています。

本リポジトリはその要件を AWS で実装したもので、以下を扱っています。

- 静的サイトを HTTPS + 独自ドメインで配信
- API + サーバーレス関数 + NoSQL DB による訪問者カウンター
- インフラの全リソースを Terraform でコード管理
- GitHub Actions による自動テスト・デプロイ

## アーキテクチャ

```
                              ┌──────────────┐
                              │   Route 53   │
                              │ (crc-prac.com)│
                              └──────┬───────┘
                                     │
                              ┌──────▼───────┐        ┌─────────┐
                User ───────► │  CloudFront  │ ◄──────│   ACM   │
                              │   (+ WAF)    │        └─────────┘
                              └──────┬───────┘
                                     │ OAC
                              ┌──────▼───────┐
                              │      S3      │ ← 静的サイト
                              └──────────────┘

                User ──► CloudFront ──► API Gateway ──► Lambda ──► DynamoDB
                                                       (Python)   (訪問者数)
```

## ディレクトリ構成

```
.
├── frontend/                # レジュメサイト (Vite + React + TypeScript)
│   ├── src/
│   └── public/
├── lambda/                  # 訪問者カウンター API (Python)
│   ├── visitor_couter/
│   │   └── handler.py       # Lambda ハンドラ
│   └── tests/               # pytest テスト
├── infra/
│   └── terraform/           # AWS リソース定義 (IaC)
│       ├── main.tf
│       ├── variables.tf
│       └── modules/
│           ├── s3/
│           ├── cloudfront/
│           ├── acm/
│           ├── route53/
│           ├── apigateway/
│           ├── lambda/
│           ├── iam/
│           └── dynamodb/
└── .github/
    └── workflows/
        ├── deploy-frontend.yml
        └── deploy-backend.yml
```

## 技術スタック

### フロントエンド

- **Vite** + **React 19** + **TypeScript**
- **Tailwind CSS** — スタイリング
- **Bun** — パッケージマネージャ / ランタイム

### バックエンド

- **AWS Lambda** (Python 3.14)
- **boto3** — DynamoDB アクセス
- **pytest** — ユニットテスト
- **uv** — Python パッケージマネージャ

### インフラ / AWS

- **S3** — 静的サイトホスティング（Origin Access Control 経由で非公開）
- **CloudFront** — CDN + HTTPS 終端 + WAF
- **ACM** — TLS 証明書（us-east-1）
- **Route 53** — DNS / 独自ドメイン
- **API Gateway** — Lambda へのエンドポイント
- **DynamoDB** — 訪問者数の永続化
- **IAM** — 最小権限ロール / OIDC によるデプロイ権限

### IaC / CI/CD

- **Terraform** (AWS Provider v6) — モジュール分割構成
- **GitHub Actions** — `main` ブランチへの PR マージ時に自動デプロイ
  - フロントエンド: build → S3 sync → CloudFront キャッシュ invalidate
  - バックエンド: pytest → Lambda 関数更新
- **OIDC** — long-lived AWS キーを使わない IAM ロール連携

### 開発ツール

- **mise** — ツールバージョン管理
