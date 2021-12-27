# README

テーブル構成を下記に記載します。

### labels
| column  | data_type |
|---|---|
|id  | primary_key |
|tag  | string |
|task_id(FK) | bigint |
|user_id(FK)  | bigint |

    
### tasks
    
 | column  | data_type |
|---|---|
|id  | primary_key |
|name  | string |
|content  | text |
|time  | string |
|priority  | string |
|status  | string |
|user_id(FK)  | bigint |

### users    

| column  | data_type |
|---|---|
|id  | primary_key |
|name  | string |
|email  | string |
|password_digest  | string |

## heroku deproy

1. 作業のディレクトリ、ブランチへcd
2. ``` heroku create ```
3. ```rails assets:precompile RAILS_ENV=production```
4.  gitにコミットまで行う。
5.  ```heroku buildpacks:set heroku/ruby heroku  ```
6.  ```buildpacks:add --index 1 heroku/nodejs```
7.  ```git push heroku master``` or ```git push heroku [branch]:master```
8.  ```heroku run rails db:migrate```
上記で完了。
