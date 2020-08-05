require "csv"

namespace :csv_imports do
  desc "Import World Data CSV"
  task world_data: :environment do
    puts "Importing world data..."
    #country_iso,country_name,region_name,city_name
    lines = CSV.read("./lib/assets/world_data.csv")
    lines.delete_at(0)
    bar = ProgressBar.new(lines.count)
    lines.each do |l|
      country_data = { abbrev: l[0].squish, name: l[1].squish }
      country = Country.find_or_create_by(country_data)
      region = Region.find_or_create_by(name: l[2].squish) do |r|
        r.country = country
      end
      city = City.find_or_create_by(name: l[3].squish) do |c|
        c.region = region
      end
      bar.increment!
    end
    puts "Task finished!"
  end
end
