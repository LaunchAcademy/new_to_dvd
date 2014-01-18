class WelcomeMailer < ActionMailer::Base
  default from: "notifications@rotten-tomatoes-mailer.com"

  def welcome_email(id)
    @user = User.find(id)
    mail to: @user.email, subject: 'Welcome to the Rotten Tomatoes New DVD Mailer'
  end
end
