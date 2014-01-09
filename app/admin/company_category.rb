ActiveAdmin.register CompanyCategory do

  permit_params :name

  show :title => :name do |category|
    attributes_table do
      row :id
      row :name

      row :companies do 
        ul do
          category.companies.each do |company|
            li link_to company.name, admin_company_path(company)
          end
        end
      end
    end
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
