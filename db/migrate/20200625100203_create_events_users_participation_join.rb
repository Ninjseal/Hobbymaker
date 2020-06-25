class CreateEventsUsersParticipationJoin < ActiveRecord::Migration[6.0]
  def change
    create_join_table :users, :events, table_name: :participations do |t|
      t.index [:user_id, :event_id], unique: true
    end
  end
end
