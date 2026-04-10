docker compose run -p 3000:3000 --rm rails
※ run だとcompose.ymlに書いたportの設定が無視される

rails s -p 3000 -b '0.0.0.0' -d

rails new .

```bash
# rails newしてできた、.gitは削除
rm -rf .git
```

```bash
# g
bin/rails g controller Users show
```
