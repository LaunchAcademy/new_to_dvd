class Users::RegistrationsController < Devise::RegistrationsController

  def create
    super
    if resource.persisted?
      WelcomeWorker.perform_async(resource.id)
    end
  end
end

