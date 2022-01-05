class CreateColumnTaskTime < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :time, :datetime
    
  end
end
