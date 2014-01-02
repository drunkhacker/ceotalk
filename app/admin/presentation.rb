ActiveAdmin.register Presentation do

  permit_params :url, :problem_id, :description, :user_id

  show do |pt|
    attributes_table do
      row :id
      row :url do
        link_to pt.url, pt.url, :target => "_blank"
      end
      row :description do 
        simple_format pt.description
      end
      row :problem
      row :user
      row :created_at
      row :vote_count
      row :voters do
        pt.votes.map {|v| link_to v.user.name, admin_user_path(v.user)}.join(" ").html_safe
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
