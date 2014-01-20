require 'sidekiq/web'

NewToDvd::Application.routes.draw do
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web, at: '/sidekiq'
  end

  put 'user_status', to: 'user_status#update'

  devise_for :users, controllers: { registrations: 'users/registrations' }
  get "pages/index"
  root "pages#index"
end
