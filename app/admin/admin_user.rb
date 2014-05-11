ActiveAdmin.register AdminUser do
  menu label: "관리자 계정 관리", priority: 1
  permit_params :email, :password, :password_confirmation
  config.filters = false

  index do
    column :email
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count
    default_actions
  end

  #filter :email

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
