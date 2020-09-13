class AddDisableCommentsColumnPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :disable_comments, :boolean
  end
end
