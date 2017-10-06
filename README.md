# something on rails
自分のリポジトリ見たら真面目にrails書いているのが一個もなくて、じゃあなんか書くかってなった何かのrails

とりあえずこのへんをinitしとこう
~~docker(ruby)~~
~~rails~~
~~slim~~
~~mysql~~
~~rspec~~
~~annotate~~
~~pry~~
~~rubocop~~
~~guard~~
~~livereload~~
~~bullet~~

## something?
- 歴史上の人物

## ER図
https://github.com/yamatatsu/something-on-rails/blob/master/erd.pdf

## usage

### 環境構築

#### 1.railsプロセス
```
docker-compose up
```

#### 2.db構築
別プロセスで
```
docker-compose run --rm web db:create
docker-compose run --rm web db:migrate
docker-compose run --rm web db:seed
```

#### 3.アクセス
`localhost:3010` にアクセス

### ガードサーバーの起動
rubocop と livereload
```
docker-compose run --rm -p 35729:35729 web bundle exec guard
```
