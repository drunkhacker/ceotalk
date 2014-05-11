ActiveAdmin.register Company do

  menu label: "회사 관리", priority: 1
  permit_params :name, :url, :company_category_id, :logo, :featured, :tagline, :email, :address, :introduction

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
    #column :company_category
    column :created_at
    default_actions
  end

  filter :id
  filter :name
  
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
