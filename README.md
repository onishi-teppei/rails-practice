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

### マイグレーションの実施
```
> docker compose exec [コンテナ名] bin/rails db:migrate
```

```
> docker compose exec app bin/rails db:migrate
== 20240721050133 CreateOrders: migrating =====================================
-- create_table(:orders, {:comment=>"注文情報"})
   -> 0.0028s
== 20240721050133 CreateOrders: migrated (0.0028s) ============================
```

### マイグレーションの取り消し
1つ前にmigrationした内容を取り消してくれる
```
> docker compose exec app bin/rails db:rollback
```

```
> docker compose exec app bin/rails db:rollback
== 20240721050133 CreateOrders: reverting =====================================
-- drop_table(:orders, {:comment=>"注文情報"})
   -> 0.0016s
== 20240721050133 CreateOrders: reverted (0.0064s) ============================
```

### モデルの作成
app/models配下に[テーブル名.rb]を作成して、アプリがDBとのやり取りをする
