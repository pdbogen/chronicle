class CreateScenarios < ActiveRecord::Migration
  def change
    create_table :scenarios do |t|
      t.string :name
      t.boolean :retired
      t.integer :season
      t.integer :episode
      t.integer :low_tier_lower
      t.integer :low_tier_upper
      t.integer :mid_tier_lower
      t.integer :mid_tier_upper
      t.integer :high_tier_lower
      t.integer :high_tier_upper

      t.timestamps
    end
    add_index :scenarios, :name, unique: true
  end
end
