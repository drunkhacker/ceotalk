class CommentMailer < ActionMailer::Base
  default from: "drh@wafflestudio.com"

  def talk_comments_notify_email(user, videos_and_comments, posts_and_comments, user_comments)
    @user = user
    @videos_and_comments = videos_and_comments
    @posts_and_comments = posts_and_comments
    @user_comments = user_comments

    logger.debug"@user_comments.length = #{@user_comments.length}"

    mail(to: @user.email, subject: "CEO MBA #{@user.name}님의 컨텐츠에 새롭게 달린 댓글입니다!")
  end
end
