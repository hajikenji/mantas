json.extract! task, :id, :name, :content, :time, :priority, :created_at, :updated_at
json.url task_url(task, format: :json)
