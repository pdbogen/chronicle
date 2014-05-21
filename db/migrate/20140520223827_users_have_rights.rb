class UsersHaveRights < ActiveRecord::Migration
  def change
    create_table :rights_users, id: false do |t|
      t.belongs_to :user
      t.belongs_to :right
    end
    rename_column :users, :id, :user_id
    rename_column :rights, :id, :right_id
  end
end
