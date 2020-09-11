class CreateInterestsPostsJoin < ActiveRecord::Migration[6.0]
  def change
    create_table :interests_posts, id: false do |t|
      t.integer :interest_id, null: false
      t.integer :post_id, null: false
    end
    add_index :interests_posts, [:interest_id, :post_id], unique: true
  end
end
