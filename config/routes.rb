Rails.application.routes.draw do
  devise_for :users
  root to: 'homepage#show', as: :root

  resources :questions do
    get :follow, on: :member
    get :unfollow, on: :member
  end
  resources :answers, only: [:create] do
    get :vote_up, on: :member
    get :vote_down, on: :member
  end
end
