class RemoveInterestIdColumnPosts < ActiveRecord::Migration[6.0]
  def change
    remove_column :posts, :interest_id, :integer
  end
end
