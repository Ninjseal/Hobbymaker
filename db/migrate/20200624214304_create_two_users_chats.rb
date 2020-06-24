class CreateTwoUsersChats < ActiveRecord::Migration[6.0]
  def change
    create_table :two_users_chats do |t|
      t.integer :user1_id, null: false
      t.integer :user2_id, null: false
      t.timestamps
    end
    add_index :two_users_chats, [:user1_id, :user2_id], unique: true
  end
end
