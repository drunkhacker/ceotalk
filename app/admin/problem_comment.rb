ActiveAdmin.register ProblemComment do
  permit_params :user_id, :content, :parent_id, :picked, :commentable_id, :commentable_type
  config.filters = false
  
  form do |f|
    f.inputs do
      f.input :user, :as => :select, :label => "사용자"
      f.input :content, :as => :text
      f.input :parent, :collection => ProblemComment.where(:commentable_id => f.object.commentable_id).where.not(:id => f.object.id)
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
    column :content
    column :picked
    column :commentable
    column :parent
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
