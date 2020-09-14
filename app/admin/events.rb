ActiveAdmin.register Event do
  actions :all, except: [:new, :edit]

  index do
    selectable_column
    id_column
    column :thumbnail do |e|
      image_tag e.thumbnail.url, style:"height:125px;width:200px;"
    end
    column :name
    column :start_date
    column :end_date
    column "Kind" do |e|
      e.kind.titleize
    end
    column :city
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :thumbnail do |e|
          image_tag e.thumbnail.url, style:"height:200px;width:300px;"
      end
      row :name
      row "Organizers" do |e|
        e.organizers.map do |u|
          link_to(u.name, admin_user_url(u))
        end.join(", ").html_safe
      end
      row "Interests" do |e|
        e.interests.map do |i|
          link_to(i.name, admin_interest_url(i))
        end.join(", ").html_safe
      end
      row :start_date
      row :end_date
      row "Kind" do |e|
        e.kind.titleize
      end
      row(:city) if event.city_id?
      row(:location) if event.location?
      row :created_at
      row :description do |e|
        raw(e.description)
      end
    end
  end

  filter :name
  filter :start_date
  filter :end_date
  filter :kind, as: :select, collection: Event.kinds.transform_keys(&:titleize)
  filter :created_at

end
