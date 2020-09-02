class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.integer :interest_id, null: false
      t.integer :created_by, null: false
      t.timestamps
    end
  end
end
