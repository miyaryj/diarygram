class CreateUsersFollowers < ActiveRecord::Migration
  def change
    create_table :users_followers do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps null: false
    end

    add_index :users_followers, :follower_id
    add_index :users_followers, :followed_id
    add_index :users_followers, [:follower_id, :followed_id], unique: true
  end
end
