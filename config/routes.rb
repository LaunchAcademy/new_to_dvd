require 'sidekiq/web'

NewToDvd::Application.routes.draw do
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web, at: '/sidekiq'
  end

  devise_for :users, controllers: { registrations: 'users/registrations' }
  get "pages/index"
  root "pages#index"
end
