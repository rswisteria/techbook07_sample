# Ruby on Railsチュートリアル

これは技術書典7で頒布した「Webサービスを支える運用設計」のサンプルアプリケーションです。
アプリケーション自体は[Ruby on Railsチュートリアル](https://railstutorial.jp/)で作成したマイクロブログアプリケーションに、
上記書籍で言及するいくつかのサービスの設定を含むものとなっています。

## 開発環境

docker-composeを利用して開発環境を構築することが出来ます。
Docker環境のセットアップに関しては以下のドキュメントも参照してください。

- [Dockerのインストール](http://docs.docker.jp/engine/installation/index.html)
- [Docker Composeのインストール](http://docs.docker.jp/compose/install.html)

dockerならびにdocker-composeが利用できるようになったら、以下のコマンドを実行することでRuby on Railsのアプリケーションが起動します。

```shell script
docker-compose build
docker-compose up -d
docker-compose exec web bin/rails db:create
docker-compose exec web bin/rails db:migrate
docker-compose exec web bin/rails s -b 0.0.0.0 -p 3000
```

## 環境変数について

このアプリケーションは本番環境で動作させる際に、いくつかの外部サービスを利用するように作られています。
それらのサービスを利用するために、外部サービスへの接続情報や認証トークン等を環境変数で設定する必要があります。

### アプリケーション全般

| 環境変数 | 説明 |
| -------- | ---- |
| APP_HOST | アプリケーションのホスト名。メール内に含まれるURLのホスト名部分に利用されます |

### PostgreSQL

このアプリケーションはデータベースにPostgreSQLを利用するように設定しています。

production環境では以下の環境変数でPostgreSQLデータベースへの接続先を設定します。

| 環境変数 | 説明 |
| -------- | ---- |
| DATABSE_URL | postgres://<ユーザー名>:<パスワード>@<ホスト名>:<ポート番号>/<データベース名> |

config/database.ymlでこの環境変数を参照します。

Herokuを利用する場合、Postgresプラグインの設定を行うことで、自動的に上記の環境変数が設定されます。

### AWS S3

このアプリケーションでは画像ファイルのアップロードを行う際、carrier_waveを利用しています。
本番環境ではcarrier_waveを介して、S3に画像ファイルを保存するようにしています。

production環境では以下の環境変数でAWS S3への接続情報を設定します。

| 環境変数              | 説明 |
| --------------------- | ---- |
| AWS_ACCESS_KEY_ID     | S3に接続するIAMユーザーのアクセスキー |
| AWS_SECRET_ACCESS_KEY | S3に接続するIAMユーザーのシークレットアクセスキーキー |
| AWS_REGION            | S3のリージョン (例: ap-northeast-1) |
| S3_BUCKET             | 画像ファイルを保存するS3のバケット名 |

上記で設定するIAMユーザーには画像ファイルを保存するS3バケットに対して以下の権限の設定を行う必要があります。

- s3:GetObject
- s3:PutObject

config/initializers/carrier_wave.rbでこの環境変数を参照します。

### Sendgrid

このアプリケーションはユーザー管理等でメールを送信する機能があります。
メールの送信は[Sendgrid](https://sendgrid.com/)を利用して実現しています。

production環境では以下の環境変数でSendgridの接続情報を設定します。

| 環境変数          | 説明 |
| ----------------- | ---- |
| SENDGRID_USERNAME | Sendgridで利用するSMTPユーザー名 |
| SENDGRID_PASSWORD | Sendgridで利用するSMTPパスワード |

Herokuを利用する場合、Sendgridプラグインの設定を行うことで、自動的に上記の環境変数が設定されます。

config/environments/production.rbでこの環境変数を参照します。

### NewRelic

このアプリケーションのプロファイリングのために[NewRelic](https://newrelic.com/)を利用しています。
production環境にて、以下の環境変数を設定する必要があります。

| 環境変数             | 説明 |
| -------------------- | ---- |
| NEW_RELIC_LICENSE_KEY | NewRelicのライセンスキー |

Herokuを利用する場合、NewRelicプラグインの設定を行うことで、自動的に上記の環境変数が設定されます。

config/newrelic.ymlでこの環境変数を参照します。