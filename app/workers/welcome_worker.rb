class WelcomeWorker
  include Sidekiq::Worker

  def perform(user_id)
    WelcomeMailer.welcome_email(user_id).deliver
  end
end

