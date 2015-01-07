Rails.application.routes.draw do
  get 'static_pages/home'

  root to: "static_pages#home"
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    omniauth_callbacks: "users/omniauth_callbacks"
  }

end
