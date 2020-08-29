class CreateReports < ActiveRecord::Migration[6.0]
  def change
    create_table :reports do |t|
      t.integer :user_id, null: false
      t.integer :reported_item_id, null: false
      t.string :reported_item_type, null: false
      t.integer :reason, null: false
      t.string :message
      t.integer :status, null: false
      t.timestamps
    end

  end
end
