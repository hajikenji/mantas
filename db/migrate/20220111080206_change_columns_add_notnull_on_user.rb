class ChangeColumnsAddNotnullOnUser < ActiveRecord::Migration[6.0]
  def change
    change_column_null :users, :admin, false, false
  end
end
