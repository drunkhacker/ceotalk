ActiveAdmin.register ProblemComment do
  permit_params :user_id, :content, :parent_id, :picked, :commentable_id, :commentable_type
  
  form do |f|
    f.inputs do
      f.input :user, :as => :select, :label => "사용자"
      f.input :content, :as => :text
      f.input :parent
      f.input :picked
      f.input :commentable, :collection => Problem.all

      # hidden input으로 강제로 Problem이라고 commentable type을 지정해줌. 
      f.input :commentable_type, :value => "Problem", :as => :hidden
    end
    f.actions
  end

  index do
    selectable_column
    column :id
    column :user
    column :commentable
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
