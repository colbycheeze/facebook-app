Rails.application.routes.draw do
  get 'static_pages/home'

  root to: "static_pages#home"
  resources :users, only: [:index, :show]
  devise_for :users, path: '', path_names: { sign_in: "login", sign_out: "logout", sign_up: "register"}, controllers: {
    sessions: 'users/sessions',
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  
end
