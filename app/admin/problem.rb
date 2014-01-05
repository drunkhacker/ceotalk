ActiveAdmin.register Problem do
  permit_params :url, :title, :professional_id, :content, :phase, :phase1_deadline, :phase2_deadline, :thumb_url

  form do |f|
    f.inputs do
      f.input :title, :label => "제목"
      f.input :url, :label => "URL" 
      f.input :thumb_url, :as => :image_preview, :label => "썸네일" 
      f.input :professional, :as => :select, :label => "전문가"
      f.input :content, :as => :text
      f.input :phase, :as => :select, :collection => Problem::PHASE_TO_WORD.to_a.map {|a| a.reverse}
      f.input :phase1_deadline, :as => :date_picker
      f.input :phase2_deadline, :as => :date_picker
    end
    f.actions
  end

  index do
    selectable_column
    column :id
    column :title, :sortable => :title do |problem|
      link_to problem.title, admin_problem_path(problem)
    end
    column :phase do |problem|
      Problem::PHASE_TO_WORD[problem.phase]
    end
    column :phase1_deadline
    column :phase2_deadline
    column :comment_count do |problem|
      problem.comments.count
    end

    default_actions
  end

  show :title => :title do |problem|
    attributes_table do
      row :id
      row :url do
        link_to problem.url, problem.url, :target => "_blank"
      end
      row :content do
        simple_format problem.content
      end
      row :professional
      row "진행 상황" do 
        Problem::PHASE_TO_WORD[problem.phase]
      end
      row "예선 마감" do 
        problem.phase1_deadline
      end
      row "결선 마감" do
        problem.phase2_deadline
      end
      row "답글 갯수" do
        problem.comments.count
      end

      row "결선 PT" do
        ul do 
          problem.presentations.each do |pt|
            li do 
              (link_to "Presentation #{pt.id}", admin_presentation_path(pt) ) + " - " +
              (link_to pt.user.name, admin_user_path(pt.user)) + " #{pt.created_at}"
            end
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
