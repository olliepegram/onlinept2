Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :listings do
    resources :orders
  end
  get 'pages/about'

  get 'pages/contact'

  root 'listings#index'

  get 'seller' => "listings#seller"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
