ActiveAdmin.register Poll do
  actions :all, except: [:new, :edit]

  index do
    selectable_column
    id_column
    column :owner
    column :question
    column :allow_multiple_answers
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :question
      row :owner
      row :allow_multiple_answers
      row :created_at
      row "Poll Options" do |p|
        attributes_table_for :poll_options do
          p.options.each do |o|
            row :answer do
              o.answer
            end
          end
        end
      end
    end
  end

  filter :question
  filter :allow_multiple_answers
  filter :created_at

end
