ActiveAdmin.register Post do

  permit_params :url, :professional_id, :title, :excerpt, :thumb_url, :created_at, :category_id

  form do |f|
    f.inputs do
      f.input :url, :label => "URL"
      f.input :title, :placeholder => "URL을 입력하면 자동생성", :label => "제목"
      f.input :excerpt, :placeholder => "URL을 입력하면 자동생성", :as => :html_preview, :label => "요약"
      f.input :thumb_url, :label => "썸네일", :as => :image_preview
      f.input :professional, :as => :select, :label => "전문가"
      f.input :created_at, :label => "생성시각", :as => :date_picker
    end

    f.actions
  end

  index do
    selectable_column
    column :id
    column :title, :sortable => :title do |post|
      link_to post.title, admin_post_path(post)
    end
    column :professional
    column :url do |post|
      link_to post.url, post.url, :target => "_blank"
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
