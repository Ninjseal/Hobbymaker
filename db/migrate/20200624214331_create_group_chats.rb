class CreateGroupChats < ActiveRecord::Migration[6.0]
  def change
    create_table :group_chats do |t|
      t.string :name, null: false
      t.timestamps
    end
    add_index :group_chats, :name, unique: true
  end
end
