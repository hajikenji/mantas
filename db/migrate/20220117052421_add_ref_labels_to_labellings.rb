class AddRefLabelsToLabellings < ActiveRecord::Migration[6.0]
  def change
    add_reference :labellings, :label, foreign_key: true
  end
end
