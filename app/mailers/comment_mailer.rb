class CommentMailer < ActionMailer::Base
  default from: "drh@wafflestudio.com"

  def talk_comments_notify_email(user, talks_and_comments)
    @user = user
    @talks_and_comments = talks_and_comments
    mail(to: "jay.kim024@gmail.com", subject: "CEO MBA #{@user.name}님의 컨텐츠에 새롭게 달린 댓글입니다!")
  end
end
