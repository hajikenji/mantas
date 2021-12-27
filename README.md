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
