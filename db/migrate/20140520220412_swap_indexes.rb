class SwapIndexes < ActiveRecord::Migration
  def change
    remove_index :users, column: :email
    add_index :users, :username, unique: true
  end
end
