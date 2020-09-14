ActiveAdmin.register User do
  permit_params :email, :password, :profile_photo

  index do
    selectable_column
    id_column
    column :profile_photo do |u|
      image_tag u.profile_photo.url, style: "height: 70px;width:auto;border-radius:50%;"
    end
    column :email
    column :name
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :profile_photo do |u|
          image_tag u.profile_photo.url, style:"height:200px;width:auto;border-radius:50%;"
      end
      row :email
      row :name
      row :created_at
    end
  end

  filter :email
  filter :name
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :name
      f.input :password
    end
    f.actions
  end

end
