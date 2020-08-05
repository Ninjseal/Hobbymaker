class CreateCities < ActiveRecord::Migration[6.0]
  def change
    create_table :cities do |t|
      t.string :name
      t.integer :region_id, null: false
      t.timestamps
    end

    add_index :cities, :name
  end
end
