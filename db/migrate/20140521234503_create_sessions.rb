class CreateSessions < ActiveRecord::Migration
  def change
    create_table :play_sessions do |t|
      t.string :name
      t.boolean :gm
      t.references :user, index: true
      t.references :scenario, index: true
      t.datetime :played_at
      t.integer :tier

      t.timestamps
    end
  end
end
