class CreateCountries < ActiveRecord::Migration[6.0]
  def change
    create_table :countries do |t|
      t.string :name, null: false
      t.string :abbrev, null: false
      t.timestamps
    end

    add_index :countries, :name, unique: true
  end
end
