class CreateInstagramUsers < ActiveRecord::Migration
  def change
    create_table :instagram_users do |t|
      t.string :name
      t.integer :user_id
      t.string :instagram_user_id
      t.string :profile_image_url

      t.timestamps null: false
    end

    add_index(:instagram_users, :user_id)
  end
end
