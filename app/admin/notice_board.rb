ActiveAdmin.register_page "Notice Board" do
  menu label: "공지사항", priority: 7
  content do
    script <<-EOF
      // Create IE + others compatible event handler
      var eventMethod = window.addEventListener ? "addEventListener" : "attachEvent";
      var eventer = window[eventMethod];
      var messageEvent = eventMethod == "attachEvent" ? "onmessage" : "message";
      var old = 200;

      // Listen to message from child window
      eventer(messageEvent,function(e) {
        console.log('parent received message!:  ',e.data);

        d = e.data.split("=");
        v = parseInt(d[1]);
        if (d[0] == 'h' && v != old) {
          $("#board-iframe").css("height", v + "px");
          old = v;
        }
      },false);
      document.domain = "#{request.host}";
      EOF
      .html_safe
 
    iframe :id => "board-iframe", :style => "padding:0; margin:0; width: 100%; min-height: 200px;", :frameborder => 0, :src => "//#{request.host}:8080/index.php?mid=#{ENV["XE_BOARD_MID"]}"
  end
end

