class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.string :location
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false
      t.timestamps
    end

    add_index :events, :name
    add_index :events, :start_date
    add_index :events, :end_date
  end
end
