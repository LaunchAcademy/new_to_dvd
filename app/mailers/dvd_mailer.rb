class DVDMailer < ActionMailer::Base
  default from: "notifications@rotten-tomatoes-mailer.com"

  def new_releases(info_id, user_id)
    @movies = ReleaseInfo.find(info_id).data.values.map{|d| eval(d)}
    @user = User.find(user_id)
    mail to: @user, subject: 'Here are the newest DVD releases'
  end
end
