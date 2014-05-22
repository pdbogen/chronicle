class UsersHaveRights < ActiveRecord::Migration
  def change
    create_table :rights_users, id: false do |t|
      t.belongs_to :user
      t.belongs_to :right
    end
  end
end
