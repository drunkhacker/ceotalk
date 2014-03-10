class CommentMailer < ActionMailer::Base
  default from: '"CEO MBA" <ask@ceomba.co.kr>'

  def talk_comments_notify_email(user, videos_and_comments, posts_and_comments, user_comments)
    @user = user
    @videos_and_comments = videos_and_comments
    @posts_and_comments = posts_and_comments
    @user_comments = user_comments

    logger.debug"@user_comments.length = #{@user_comments.length}"

    mail(to: @user.email, subject: "CEO MBA | (#{Time.now.localtime.strftime("%y.%m.%d")})#{@user.name}님의 컨텐츠의 새로운 댓글을 알려드립니다.")
  end
end
