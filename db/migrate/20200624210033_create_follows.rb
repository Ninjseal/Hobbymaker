class CreateFollows < ActiveRecord::Migration[6.0]
  def change
    create_table :follows, id: false do |t|
      t.integer :follower_id, null: false
      t.integer :following_id, null: false
    end
    add_index :follows, [:follower_id, :following_id], unique: true
  end
end
