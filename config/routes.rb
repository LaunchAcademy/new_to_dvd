NewToDvd::Application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  get "pages/index"
  root "pages#index"
end
