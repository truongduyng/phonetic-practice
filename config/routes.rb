Rails.application.routes.draw do
  root 'checks#new'
  resources :checks
end
