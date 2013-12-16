ActiveAdmin.register Talk do

  permit_params :url, :description, :professional_id, :thumb_url, :created_at, :title, :category_id

  form do |f|
    f.inputs do
      f.input :title, :label => "제목"
      f.input :url, :label => "URL"
      f.input :thumb_url, :as => :image_preview, :label => "썸네일"
      f.input :description, :label => "설명"
      f.input :professional, :as => :select, :label => "전문가"
      f.input :category
      f.input :created_at, :label => "생성시각", :as => :date_picker
    end
    f.actions
  end

  index do
    selectable_column
    column :id
    column :title, :sortable => :title do |talk|
      link_to talk.title, admin_talk_path(talk)
    end
    column :professional, :sortable => :name
    column :url do |talk|
      link_to talk.url, talk.url, :target => "_blank"
    end
    column :category
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
