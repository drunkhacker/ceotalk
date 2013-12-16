ActiveAdmin.register User do

  permit_params :name, :type, :company_id

  form do |f|
    f.inputs do
      f.input :name
      f.input :type, :as => :boolean, :checked_value => "Professional", :unchecked_value => "User", :label => "전문가"
      f.input :company
    end
    f.actions
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
