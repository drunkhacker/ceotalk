ActiveAdmin.register User do

  permit_params :name, :type, :company_id, :expert_category_id

  form do |f|
    f.inputs do
      f.input :name
      f.input :type, :as => :boolean, :checked_value => "Professional", :unchecked_value => "User", :label => "전문가"
      f.input :company
      f.input :expert_category
    end
    f.actions
  end

  index do
    selectable_column
    column :id
    column :name, :sortable => :name do |user|
      link_to user.name, admin_user_path(user)
    end
    column :email
    column :sign_in_count
    column :last_sign_in_at
    column :type
    column :expert_category
    column :facebook do |user|
      if user.provider == "facebook"
        link_to user.uid, "https://facebook.com/#{user.uid}", :target => "_blank"
      end
    end
    column :created_at
    default_actions
  end

  show :title => :name do
    div :style => "float :right; margin-top: 40px; margin-right: 20px; padding:10px; background:white;" do
      if user.profile_photo.url
        image_tag user.profile_photo.url
      end
    end
    attributes_table do
      row :id
      row :name
      row :email do
        link_to user.email, "mailto:#{user.email}"
      end
      row :company
      row :sign_in_count
      row :last_sign_in_at
      row :type
      row :facebook do
        link_to user.uid, "https://facebook.com#{user.uid}", :target => "_blank" if user.provider == "facebook"
      end
      row :created_at
      row :comment_count do
        user.comments.count
      end
      if user.class == Professional
        row :column_count do
          user.posts.count
        end
        row :talk_count do
          user.talks.count
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
