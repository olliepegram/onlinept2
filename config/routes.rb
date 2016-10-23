Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :listings do
    resources :orders, only: [:new, :create]
  end

  post 'comments' => 'comments#create', as: "create_comment"
  
  get 'pages/about'

  get 'pages/contact'

  root 'listings#index'
   match "/listings/add_new_comment" => "listings#add_new_comment", :as => "add_new_comment_to_posts", :via => [:listing]

  get 'seller' => "listings#seller"
  get 'sales' => "orders#sales"
  get 'purchases' => "orders#purchases"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
