class DeleteColumnTaskTime < ActiveRecord::Migration[6.0]
  def change
    remove_column :tasks, :time
  end
end
