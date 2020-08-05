class AddCityIdToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :city_id, :integer
  end
end
