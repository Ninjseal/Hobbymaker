class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.text :content, null: false
      t.integer :user_id, null: false
      t.integer :chat_id, null: false
      t.string :chat_type, null: false
      t.timestamps
    end
    add_index :messages, :user_id
    add_index :messages, :chat_id
  end
end
