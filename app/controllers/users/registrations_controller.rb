class Users::RegistrationsController < Devise::RegistrationsController

  def create
    super
    if resource.persisted?
      WelcomeMailer.welcome_email(resource.id).deliver
    end
  end

end
