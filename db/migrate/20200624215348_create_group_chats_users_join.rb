class CreateGroupChatsUsersJoin < ActiveRecord::Migration[6.0]
  def change
    create_table :group_chats_users, id: false do |t|
      t.integer :group_chat_id, null: false
      t.integer :user_id, null: false
    end
    add_index :group_chats_users, [:group_chat_id, :user_id], unique: true
  end
end
