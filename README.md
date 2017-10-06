# something on rails
自分のリポジトリ見たら真面目にrails書いているのが一個もなくて、じゃあなんか書くかってなった何かのrails

とりあえずこのへんをinitしとこう
- ~~docker(ruby)~~
- ~~rails~~
- ~~slim~~
- ~~mysql~~
- ~~rspec~~
- ~~annotate~~
- ~~pry~~
- ~~rubocop~~
- ~~guard~~
- ~~livereload~~
- ~~bullet~~

## something?
- 歴史上の人物
  - 池田ノート
    - レキシの人の本名が池田らしい

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
docker-compose run --rm web rails db:create
docker-compose run --rm web rails db:migrate
docker-compose run --rm web rails db:seed
```

#### 3.アクセス
`localhost:3010` にアクセス

seedで作られるアカウント
- id / pass
  - shiki@shiki.boon / murasaki

### ガードサーバーの起動
rubocop と livereload
```
bin/docker-guard
```

### imageのpush
gem追加したらやっくと楽だよ
```
bin/docker-push
```

### yamatatsu193/somethingonrails_web:latest が手に入らない時
dockerhubのリポジトリ消した？
ともあれ以下で出来上がるはず
```
docker-compose -f docker-compose.initialize.yml up
```

終わったら `bin/docker-push` しとくといいと思う。
