class AddTableTask < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :status, :string
  end
end
