class ChangeDataTaskPriority < ActiveRecord::Migration[6.0]
  def change
    remove_column :tasks, :priority
    add_column :tasks, :priority, :integer
  end
end
