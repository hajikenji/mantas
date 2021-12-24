class AddTableTask < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :status
    end
  end
end
