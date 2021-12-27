# README

テーブル構成を下記に記載します。

### create_table "labels"

    string "tag"
    
    bigint "user_id", null: false
    bigint "task_id", null: false
    index ["task_id"], name: "index_labels_on_task_id"
    index ["user_id"], name: "index_labels_on_user_id"


 ### create_table "tasks"
  
    string "name"
    text "content"
    string "time"
    string "priority"
    string "status"
    
    bigint "user_id", null: false
    index ["user_id"], name: "index_tasks_on_user_id"


  ### create_table "users"
  
    string "name"
    string "email"
    string "password_digest"
    
    index ["email"], name: "index_users_on_email", unique: true
 
foreign_key
```
  add_foreign_key "labels", "tasks"　
  add_foreign_key "labels", "users"　
  add_foreign_key "tasks", "users"　
  ```

