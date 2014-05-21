class CreateRights < ActiveRecord::Migration
  def change
    create_table :rights do |t|

      t.timestamps
    end
  end
end
