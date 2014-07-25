class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :name, limit: 128
      t.text :levels
      t.integer :total_levels
      t.string :avatar, limit: 128

      t.timestamps

      t.belongs_to :user
    end
  end
end
