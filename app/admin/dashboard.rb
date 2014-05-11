ActiveAdmin.register_page "Dashboard" do

  menu :priority => 0, :label => "메인"

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    #div :class => "blank_slate_container", :id => "dashboard_default_message" do
      #span :class => "blank_slate" do
        #span I18n.t("active_admin.dashboard_welcome.welcome")
        #small I18n.t("active_admin.dashboard_welcome.call_to_action")
      #end
    #end

    # Here is an example of a simple dashboard with columns and panels.
    #
     columns do
       column do
         panel "WordPress 바로가기" do
           para "컬럼 글을 등록하기 위한 블로그 관리자 화면으로 이동" 
           para do
             link_to "바로가기", "http://blog.ceomba.co.kr/wp-admin", :class => "button", :target => "_blank"
           end
         end
       end

       column do
         panel "게시판 관리 바로가기" do
           para "공지사항 글을 등록하기 위한 XE 관리자 화면으로 이동"
           para do
             link_to '바로가기', "http://ceomba.co.kr:8080/index.php?module=admin", :class => "button", :target => "_blank"
           end
         end
       end
     end
    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
