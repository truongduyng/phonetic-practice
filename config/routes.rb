Rails.application.routes.draw do
  root 'checks#new'
  resources :checks
  get '/questions/qoute_question', to: 'questions#show'
  get 'about', to: 'static#about'

  mount Localtower::Engine, at: 'localtower' if Rails.env.development?
end
