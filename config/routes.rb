Rails.application.routes.draw do
  mount Notifications::Engine => "/notifications"
  devise_for :users

  resources :users do
    resources :posts do
      resources :comments
    end
  end

  root 'users#index'
end
