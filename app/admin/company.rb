ActiveAdmin.register Company do

  permit_params :name, :url

  index do
    selectable_column
    column :id
    column :name, :sortable => :name do |company|
      link_to company.name, admin_company_path(company)
    end
    column :url
    column :members do |company|
      company.members.count
    end
    column :created_at
    default_actions
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
