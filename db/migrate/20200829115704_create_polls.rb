class CreatePolls < ActiveRecord::Migration[6.0]
  def change
    create_table :polls do |t|
      t.integer :user_id, null: false
      t.string :question, null: false
      t.boolean :allow_multiple_answers, null: false
      t.timestamps
    end
    add_index :polls, [:user_id, :question], unique: true
  end
end
