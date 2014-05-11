ActiveAdmin.register Post do
  menu :label => "칼럼", priority: 4
  permit_params :url, :professional_id, :title, :description, :thumb_url, :created_at, :featured, category_ids: []

  filter :url
  filter :title
  filter :professional

  member_action :toggle_featured, :method => :post do
    post = Post.find(params[:id])
    post.update_attribute(:featured, params[:featured] == "true")
    #Rails.logger.debug "post.featured = #{post.featured}"
    render :nothing => true
  end

  form do |f|

    f.form_buffers.last << "<p style=\"margin-bottom: 20px;\">".html_safe
    f.form_buffers.last << 
      if f.object.new_record?
        (link_to "칼럼 글 작성하기", "http://blog.ceomba.co.kr/wp-admin/post-new.php", :class => "button", :target => "_blank")
      else
        # parse url
        arr = f.object.url.scan(/p=([0-9]+)/)
        if arr.empty?
          ""
        else
          link_to "칼럼 수정하기", "http://blog.ceomba.co.kr/wp-admin/post.php?post=#{arr[0][0]}&action=edit", :class => "button", :target => "_blank"
        end
      end
    f.form_buffers.last << "</p>".html_safe

    f.inputs do
      f.input :url, :label => "URL"
      f.input :title, :placeholder => "URL을 입력하면 자동생성", :label => "제목"
      f.input :description, :placeholder => "URL을 입력하면 자동생성", :as => :html_preview, :label => "요약"
      f.input :thumb_url, :label => "썸네일", :as => :image_preview
      f.input :professional, :as => :select, :label => "전문가"
      f.input :categories
      f.input :created_at, :label => "생성시각", :as => :date_picker
      f.input :featured
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

    column :featured do |talk|
      check_box_tag "featured_#{talk.id}", 1, talk.featured, :class => "featured-checkbox", :talk_type => "post"
    end

    column :created_at
    default_actions
  end

  show :title => :title do |post|
    attributes_table do
      row :id
      row :url do
        link_to post.url, post.url, :target => "_blank"
      end

      row :description do
        post.description.html_safe
      end

      row :professional
      row :category do
        post.categories.map {|c| c.name}.join(" / ")
      end

      row :created_at
      row :view_count
      row :thumbnail do
        image_tag post.thumb_url, :style => "max-width: 200px"
      end
    end
  end
end
