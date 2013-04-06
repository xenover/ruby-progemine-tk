class UserMailer < ActionMailer::Base
  default from: "noreply@tk-blog.com"
  
  def new_comment_email(comment)
    @comment = comment
    #mail(
  end
end
