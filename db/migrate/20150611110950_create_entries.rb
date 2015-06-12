class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :text
      t.string :date
      t.integer :user_id
      t.string :image_url
      t.string :instagram_media_id

      t.timestamps null: false
    end
  end
end
