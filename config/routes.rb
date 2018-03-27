Rails.application.routes.draw do
  root to: 'home#index'

  resources :restaurants do
    resources :reviews
  end
  resources :cuisines
end
