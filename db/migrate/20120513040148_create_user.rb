class CreateUser < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :name, :fb_user_id, :fb_access_token
      t.timestamps
    end

    add_index :users, :fb_user_id
  end

  def down
    drop_table :users
  end
end
