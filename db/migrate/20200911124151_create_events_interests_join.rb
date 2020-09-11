class CreateEventsInterestsJoin < ActiveRecord::Migration[6.0]
  def change
    create_table :events_interests, id: false do |t|
      t.integer :event_id, null: false
      t.integer :interest_id, null: false
    end
    add_index :events_interests, [:event_id, :interest_id], unique: true
  end
end
