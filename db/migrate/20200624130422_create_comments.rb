class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.text :content, null: false
      t.integer :created_by, null: false
      t.integer :post_id, null: false
      t.integer :parent_id
      t.timestamps
    end
  end
end
