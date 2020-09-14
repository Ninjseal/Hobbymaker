ActiveAdmin.register City do

  index do
    selectable_column
    id_column
    column :name
    column :region
    column :country do |c|
      c.region.country.name.titleize
    end
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :name
      row :region
      row :country do |c|
        c.region.country.name.titleize
      end
      row :created_at
    end
  end

  filter :name
  filter :from_country_in, as: :select, collection: lambda { Country.all }, label: "Country"
  filter :from_region_in, as: :select, collection: lambda { Region.all }, label: "Region"
  filter :created_at

end
