class UserMailer < ActionMailer::Base
  default from: "tkblog404@gmail.com"
  
  def email_author_new_comment(comment)
    @comment = comment
    @post = comment.post
    mail(:to => @post.author_email, :subject => "You have a new comment on your blog post!")
  end
end
