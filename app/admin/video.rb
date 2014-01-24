ActiveAdmin.register Video do

  permit_params :url, :description, :professional_id, :thumb_url, :created_at, :title, :category_id, :featured
 
  form do |f|
    f.inputs do
      f.input :title, :label => "제목"
      f.input :url, :label => "URL"
      f.input :thumb_url, :as => :image_preview, :label => "썸네일"
      f.input :description, :label => "설명"
      f.input :professional, :as => :select, :label => "전문가"
      f.input :category
      f.input :created_at, :label => "생성시각", :as => :date_picker
      f.input :featured
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

  show :title => :title do |talk|
    attributes_table do
      row :id
      row :url do
        link_to talk.url, talk.url, :target => "_blank"
      end
      row :description do
        simple_format talk.description
      end
      row :professional
      row :category do
        talk.category.aa_breadcrumb if talk.category
      end
      row :created_at
      row :view_count
      row :thumbnail do 
        image_tag talk.thumb_url
      end
      row :preview do
        # embed video
        if talk.url.include? "youtube.com"
          # extract vid
          r = /(?:https?:\/\/)?(?:www\.)?youtube\.com\/watch\?v=([0-9a-zA-Z]+)/ 
          arr = talk.url.scan r
          unless arr.empty?
            "<iframe width=\"420\" height=\"315\" src=\"//www.youtube.com/embed/#{arr[0][0]}\" frameborder=\"0\" allowfullscreen></iframe>".html_safe
          end
        elsif talk.url.include? "vimeo.com"
          # extract vid
          r = /(?:https?:\/\/)?(?:www\.)?vimeo\.com\/([0-9a-zA-Z]+)/ 
          arr = talk.url.scan r
          unless arr.empty?
            "<iframe src=\"//player.vimeo.com/video/#{arr[0][0]}\" width=\"420\" height=\"315\" frameborder=\"0\" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>".html_safe
          end
        end
      end
    end
  end
  
end
