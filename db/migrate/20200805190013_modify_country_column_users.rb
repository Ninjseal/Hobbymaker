class ModifyCountryColumnUsers < ActiveRecord::Migration[6.0]
  def up
    rename_column :users, :country, :country_id
    change_column :users, :country_id, :integer
  end

  def down
    rename_column :users, :country_id, :country
    change_column :users, :country, :string
  end
end
