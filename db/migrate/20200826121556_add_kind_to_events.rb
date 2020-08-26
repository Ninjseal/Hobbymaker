class AddKindToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :kind, :integer, null: false
  end
end
