class CreatePollVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :poll_votes do |t|
      t.integer :user_id, null: false
      t.integer :poll_option_id, null: false
      t.integer :poll_id, null: false
      t.timestamps
    end
    add_index :poll_votes, [:user_id, :poll_option_id, :poll_id], unique: true, name: 'index_poll_votes'
  end
end
