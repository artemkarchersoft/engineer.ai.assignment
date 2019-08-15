Rails.application.routes.draw do
  devise_for :users
  root to: 'homepage#show', as: :root

  resources :questions
end
