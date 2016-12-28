Rails.application.routes.draw do
  get 'register/info1'
  get 'register/info2'
  post 'register/infoget'
  root 'visitor#main'
  get 'visitor/main'

  devise_for :users, :controllers => { omniauth_callbacks: 'user/omniauth_callbacks', registrations: "user/registrations", sessions: 'user/sessions' }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
