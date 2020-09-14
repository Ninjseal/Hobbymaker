ActiveAdmin.register Interest do
  preserve_default_filters!
  
  remove_filter :events, :posts, :users
end
