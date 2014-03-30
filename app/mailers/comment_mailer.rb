class CommentMailer < ActionMailer::Base
  default from: '"CEO MBA" <ask@ceomba.co.kr>'

  def talk_comments_notify_email(user, videos_and_comments, posts_and_comments, user_comments)
    @user = user
    @videos_and_comments = videos_and_comments
    @posts_and_comments = posts_and_comments
    @user_comments = user_comments

    logger.debug"@user_comments.length = #{@user_comments.length}"

    t = Time.now.localtime
    m = t.strftime("%m").to_i
    d = t.strftime("%d").to_i
    mail(to: @user.email, subject: "[CEOMBA #{m}월 #{d}일 알림] #{@user.name}님께 새로운 댓글이 게시되었습니다.")
  end
end
