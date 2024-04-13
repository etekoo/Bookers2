Rails.application.routes.draw do
  root to: "homes#top"
  get "/home/about" => "homes#about", as: "home_about"
  devise_for :users
  
  resources :users, only: [:show, :edit, :index, :update]
  resources :books, only: [:new, :index, :show, :edit, :update, :create, :destroy]
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
