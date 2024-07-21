## Dockerの起動停止
### イメージ更新
```
> docker compose up --build --no-start
```

### コンテナ起動
```
> > docker compose start
```

### 停止
```
> docker compose stop
```

### 削除
```
> docker compose down -v
```

### 現在の状態確認
```
> docker ps
```

## migration
### migrationファイルを作成
- docker compose exec [コンテナ名]
  - どのコンテナを指定してコマンドを実行するか指定
- bin/rails
  - Rails実行ファイル
  - rails4まではrake、それ以降はbin/railsの使用が推奨

```
> docker compose exec [コンテナ名] bin/rails g migration [ファイル名] [追加カラム]
```


```
> docker compose exec app bin/rails g migration CreateOders name:string
      invoke  active_record
      create    db/migrate/20240721050133_create_oders.rb
```
