class AddPfsNumberToUsers < ActiveRecord::Migration
  def change
    add_column :users, :pfs_number, :integer
  end
end
