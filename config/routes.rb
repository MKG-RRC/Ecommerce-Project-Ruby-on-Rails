Rails.application.routes.draw do
  root "products#index"

  resources :products, only: [:index, :show]

  resource :cart, only: [:show] do
    post "add/:id", to: "carts#add", as: :add
    post "remove/:id", to: "carts#remove", as: :remove
    post "update/:id", to: "carts#update", as: :update
  end

  get "/about",   to: "pages#show", defaults: { slug: "about" }
  get "/contact", to: "pages#show", defaults: { slug: "contact" }

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
