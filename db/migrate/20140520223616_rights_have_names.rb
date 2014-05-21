class RightsHaveNames < ActiveRecord::Migration
  def change
  	add_column :rights, :right_name, :string, null: FALSE
  	add_index :rights, :right_name, unique: TRUE
  end
end
