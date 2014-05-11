ActiveAdmin.register Category do
  menu label: "전문분야", priority: 3
  sortable tree: true, sorting_attribute: :position
  config.filters = false

  permit_params :name, :parent_id, :position

  index :as => :sortable do
    label :name
    actions
  end
  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  
end
