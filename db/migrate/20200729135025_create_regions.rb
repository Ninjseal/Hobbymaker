class CreateRegions < ActiveRecord::Migration[6.0]
  def change
    create_table :regions do |t|
      t.string :name
      t.integer :country_id, null: false
      t.timestamps
    end

    add_index :regions, :name
  end
end
