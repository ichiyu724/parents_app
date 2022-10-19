# ParentsLink

<img src="https://github.com/ichiyu724/parents_app/blob/master/app/assets/images/toppage.png">

## ParentsLink とは？

育児の悩み、不安を共有したり解決するための育児特化型の相談アプリです。また、現在地から近所のクリニックを表示したり、ワクチン接種のスケジュール管理ができます。

新米ママ、パパの初めてぶつかる不安を少しでも解消したいという思いから、SNS 形式の相談アプリを作成しました。

## アプリ URL

URL: https://parents-link.herokuapp.com/

## 使い方

・アカウント登録後、相談の投稿ができます。

・投稿一覧では他のユーザーの投稿をお気に入り登録できます。

<img src="https://github.com/ichiyu724/parents_app/blob/master/app/assets/images/readme1.png">

・投稿詳細では、コメントもできます。

・ユーザー一覧から、他のユーザーのフォローができます。

<img src="https://github.com/ichiyu724/parents_app/blob/master/app/assets/images/readme2.png">

・マイページでは、自分の投稿や、お気に入りした投稿が確認できます。

・マイページからお子さんのワクチン接種のスケジュール確認、記録ができます。

<img src="https://github.com/ichiyu724/parents_app/blob/master/app/assets/images/readme3.png">
<img src="https://github.com/ichiyu724/parents_app/blob/master/app/assets/images/readme4.png">

・GoogleMap で現在地付近のクリニックを表示することができます。(要 GPS 設定)

<img src="https://github.com/ichiyu724/parents_app/blob/master/app/assets/images/googlemap.png">

## 機能

・お悩みの投稿機能

・投稿一覧表示、投稿編集、投稿削除

・ユーザー登録

・フォロー、フォロー解除

・いいね機能

・コメント機能

・ログイン、ログアウト

・パスワード再設定

・現在地から近くのクリニックを Google Map で表示

・子供の登録機能

・子供の登録後、生年月日に応じたワクチン接種のスケジュール確認

・ワクチン接種の記録機能

## ER 図

<img src="https://github.com/ichiyu724/parents_app/blob/master/app/assets/images/ER%E5%9B%B3.png">

## ワイヤーフレーム

https://xd.adobe.com/view/9ba30a51-bee2-48f1-b4c1-397d6689aa32-cef0/

## 使用技術

### バックエンド

・Ruby 2.7.5

・Ruby on Rails 6.1.5

### フロントエンド

・HTML/SCSS/Bootstrap

・Javascript/jQuery 3.6.0

.GoogleMap API/ Place API

### インフラ

・Heroku

・AWS S3

・MySQL 8.0

### 開発環境

・Docker

### テスト

・Rspec

・Rubocop

### CI/CD

・Circle CI

### その他使用ツール

・draw.io（ER 図）

・Visual Studio Code

・Adobe XD（ワイヤーフレーム）
