class CreateFavorites < ActiveRecord::Migration[6.0]
  def change
    create_table :favorites do |t|
      t.integer :user_id, null: false
      t.integer :favorite_item_id, null: false
      t.string :favorite_item_type, null: false
      t.timestamps
    end
    add_index :favorites, [:user_id, :favorite_item_id], unique: true
  end
end
