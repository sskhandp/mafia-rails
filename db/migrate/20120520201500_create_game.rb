class CreateGame < ActiveRecord::Migration
  def up
    create_table :games do |t|
      t.string :state, :stage
      t.text :settings
      t.timestamps
    end

    add_index :games, :state
    add_index :games, :stage
  end

  def down
    remove_index :games, :state
    remove_index :games, :stage

    drop_table :games
  end
end
