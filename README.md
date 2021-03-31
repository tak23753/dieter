
# Dieter
<img src="https://user-images.githubusercontent.com/75518740/113143943-aefc7700-9267-11eb-9f67-f610531d93fd.jpg">

## サイト概要
ダイエットSNS

### サイトテーマ
苦しいダイエットを一人でやるのではなく、同じように頑張っている人と協力しながらやることで、ダイエットを成し遂げる！

### テーマを選んだ理由
自分自身がダイエットした経験があり、ダイエットにはモチベーションがとても重要だと感じ、モチベーションを保つ助けになるサービスを作りたいと思いました。
自分ひとりでダイエットするのではなく、他のユーザーの頑張っている姿を見たり、自分の決意を他のユーザーと共有することでそれを実現できると考え、このテーマを選びました。

### ターゲットユーザ
- ダイエットをしたいが、一人ではなかなか続かないという方
- どのようなダイエットが効果的なのか知りたい方
- 日々の体重や体脂肪率の変化を記録したい方

### 主な利用シーン
- 日々の体重などの記録や日記、ダイエット方法を他のユーザーと共有する。
- 他のユーザーの日々の取り組み方や、ダイエット方法などを参考にする。
- 日々の体重などの記録をグラフなどで管理できるようにする。

## 実装機能

|機能名|説明|非ログイン時利用可否|
|---|---|---|
|新規登録、ログイン(devise)|・メールアドレス、パスワードなどの情報で新規登録できる|○|
|SNS認証(omniauth)|・google、ツイッターで登録できる|○|
|投稿機能|・日記、ダイエット方法を投稿<br>・画像投稿(refile)<br>・カロリー計算(Google Apps Script)<br>・タグ機能(acts-as-taggable-on、Tag-it)|×︎|
|チャット機能(actioncable)|・リアルタイムチャット。|×|
|画像解析機能(Google Cloud Vision API)|・食品の写真からカロリーを自動計算<br>・精度は低い<br>・README最下部にうまく機能する画像を掲載しています|×︎|
|いいね機能(Ajax)|・日記、ダイエット方法のいいねを非同期で行う|×︎|
|コメント機能(Ajax)|・投稿へのコメントを非同期で行う|×|
|フォロー機能(Ajax)|・会員フォローを非同期で行う<br>・日記一覧ページにはフォロー会員の日記が表示される|×︎|
|ブロック機能|・ブロック相手からフォローされなくなる<br>・ブロック相手の投稿を表示しない、相手に自分の投稿を表示させない<br>・ブロック相手からの通知を表示しない|×︎|
|報告機能|・投稿やコメント、会員を報告し、管理者ページで管理|×︎|
|検索機能(ransack)|・投稿や会員のワード検索、詳細検索、ソートができる。|○|
|グラフ機能(amCharts)|・日記の体重、体脂肪率を折れ線グラフで表示。|○|
|カレンダー機能(simple_calendar)|・投稿した日記をカレンダーで表示。|○|
|レベル機能|・日記を投稿したときや、体重、体脂肪率が減少したときに経験値がたまり、レベルが上がる。|×|
|ランキング機能|・会員の獲得経験値を日、週、月ごとにランキング。|○|
|通知機能|・チャットや投稿へのコメント、いいねを通知。|×|
|管理者機能|・投稿や会員をまとめて管理できる。<br>・報告やお問い合わせを管理。|×|
|テスト(Rspec)|・単体テスト(model)<br>・機能テスト(system)|×|


## 設計書
https://docs.google.com/spreadsheets/d/12th6Ni3bHOwQ_j_E7f5BX2FRmzWb2iyEAmcO06ozQc0/edit#gid=1037227544

## チャレンジ要素一覧
https://docs.google.com/spreadsheets/d/11LIolmiFtRGLq7ztpPtjBHQx8L5_c0DKgPxQUITLyao/edit#gid=0

## 開発環境
- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- IDE：Cloud9

## 画像解析テスト用画像
<img src="https://user-images.githubusercontent.com/75518740/113121670-d8a8a480-924d-11eb-9b6e-e068af90c96d.png">
<img src="https://user-images.githubusercontent.com/75518740/113121766-eeb66500-924d-11eb-9b26-fa0b9dff0bc3.jpg">
