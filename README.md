# awesomebook

## 『前処理大全』のサンプルコード

本橋智光　著、株式会社ホクソエム　監修
B5変／366ページ／本体価格3,000円＋税
ISBN978-4-7741-9647-3
技術評論社、2018年発行


## 各言語の前処理実行方法

### SQLの前処理実行

1. AWS Redshiftの準備
  - https://aws.amazon.com/jp/redshift/getting-started/
2. SQL Workbench/J を使用して、Redshiftに接続
  - https://docs.aws.amazon.com/ja_jp/redshift/latest/mgmt/connecting-using-workbench.html
3. AWS S3の準備
  - https://aws.amazon.com/jp/s3/
4. S3にデータをアップロード
  - dataフォルダ配下のcsvをs3上にアップロード
5. DDLを実行
  - preprocess/load_data/ddl配下のDDLのSQLにAWSのKey情報を設定し、実行
6. 各前処理の実行
  - preprocessフォルダ配下の前処理コードを実行

### Rの前処理実行

1. Rのインストール
  - https://www.r-project.org/
2. RStudioのインストール
  - https://www.rstudio.com/products/rstudio/
3. RStudioの起動
  - インストールしたRStudioを起動
4. WorkinkDirectoryの設定
  - ```setwd('awesomebook_codeのパス')```
5. コードに必要なパッケージをインストール
  - ```install.packages('パッケージ名')```
6. 各前処理の実行
  - preprocessフォルダ配下の前処理コードを実行


### Pythonの前処理実行

1. Python3のインストール
  - https://www.python.org/
2. PyCharmのインストール
  - https://www.jetbrains.com/pycharm/
3. PyCharmの起動
  - インストールしたPyCharmを起動
4. ターミナルからpipコマンドを実行して、コードに必要なライブラリをインストール
  - ```pip3 install ライブラリ名```
5. 各前処理の実行
  - preprocessフォルダ配下の前処理コードを実行


## 目次

- はじめに
- Part1 入門前処理
- 第1章 前処理とは
- Part2 データ構造を対象とした前処理
- 第2章 抽出
- 第3章 集約
- 第4章 結合
- 第5章 分割
- 第6章 生成
- 第7章 展開
- 第8章 数値型
- 第9章 カテゴリ型
- 第10章 日時型
- 第11章 文字型
- 第12章 位置情報型
- Part4 実践前処理
- 第13章 演習問題

## サポートページ

http://gihyo.jp/book/2018/978-4-7741-9647-3

## ライセンス

https://github.com/ghmagazine/awesomebook/blob/master/LICENSE
