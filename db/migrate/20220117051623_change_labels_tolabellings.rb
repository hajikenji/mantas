class ChangeLabelsTolabellings < ActiveRecord::Migration[6.0]
  def change
    rename_table :labels, :labellings
  end
end
