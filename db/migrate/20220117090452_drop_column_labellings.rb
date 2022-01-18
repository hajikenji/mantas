class DropColumnLabellings < ActiveRecord::Migration[6.0]
  def change
    remove_column :labellings, :user_id
    remove_column :labellings, :tag
  end
end
