class ChangeNameColumnLabel < ActiveRecord::Migration[6.0]
  def change
    rename_column :labels, :name, :label_name
  end
end
