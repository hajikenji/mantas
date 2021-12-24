class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :content
      t.string :time
      t.string :priority

      t.timestamps
    end
  end
end
