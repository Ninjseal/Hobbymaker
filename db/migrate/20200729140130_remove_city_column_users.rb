class RemoveCityColumnUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :city, :string
  end
end
