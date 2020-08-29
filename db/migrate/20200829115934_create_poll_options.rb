class CreatePollOptions < ActiveRecord::Migration[6.0]
  def change
    create_table :poll_options do |t|
      t.integer :poll_id, null: false
      t.string :answer, null: false
      t.timestamps
    end
    add_index :poll_options, [:poll_id, :answer], unique: true
  end
end
