class NullableEmail < ActiveRecord::Migration
  def change
    change_column :users, :email, :string, :null => TRUE
  end
end
