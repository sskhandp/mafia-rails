class CreateMemberships < ActiveRecord::Migration
  def up
    create_table :memberships do |t|
      t.references :user
      t.references :game
      t.string :state
    end
  end

  def down
    drop_table :memberships
  end
end
