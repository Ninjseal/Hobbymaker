ActiveAdmin.register Post do
  permit_params :disable_comments

  actions :all, except: [:new, :edit]

  index do
    selectable_column
    id_column
    column :thumbnail do |p|
      image_tag p.thumbnail.url, style:"height:125px;width:200px;"
    end
    column :title
    column :creator
    column :created_at
    column :updated_at
    toggle_bool_column :disable_comments
    actions
  end

  show do
    attributes_table do
      row :thumbnail do |p|
          image_tag p.thumbnail.url, style:"height:200px;width:300px;"
      end
      row :title
      row :creator
      row :created_at
      row :updated_at
      row :disable_comments
      row :content do |p|
        raw(p.content)
      end
    end
  end

  filter :title
  filter :creator
  filter :created_at

end
