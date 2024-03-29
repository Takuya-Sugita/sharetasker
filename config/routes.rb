Rails.application.routes.draw do

  root 'home#top'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :users, :controllers => {
      :registrations => 'users/registrations',
      :sessions => 'users/sessions',
      :passwords => 'users/passwords',
      :confirmations => 'users/confirmations'
  }


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_scope :user do
    get "signup", :to => "users/registrations#new"
    get "login", :to => "users/sessions#new"
    post "login" => "users/sessions#create"
    post 'users/create' => 'users/registrations#create'
    post "logout", :to => "users/sessions#destroy"
    post  "repassword" => "users/passwords#create"
    get "repassword" => "users/passwords#edit", as: "edit_password"
    get "reconfirm" => "users/confirmations#new"
    post "reconfirm" => "users/confirmations#create", as: "send_reconfirm"
  end

  post 'likes/:post_id/create' => 'likes#create', as: "likes_create"
  post 'likes/:post_id/destroy' => 'likes#destroy', as: "likes_destroy"

  get 'users/index' => 'users#index'
  get 'users/new' => 'users#new'
  get 'users/follows' => 'users#follows', as: "follows"
  get 'users/search' => 'users#search'
  get 'users/:id' => 'users#show', as: 'profile'
  post 'users/:id/update' => 'users#update', as: "image_update"
  # post 'users/create' => 'users/registrations#create'
  # get 'users/:id/edit' => 'users#edit'
  # get 'users/:id/likes' => 'users#likes'
  # get 'users/:id/followers' => 'users#followers'

  post 'relationships/:id/create' => 'relationships#create'
  post 'relationships/:id/destroy' => 'relationships#destroy'


  get 'posts/index' => 'posts#index'
  get 'posts/new' => 'posts#new'
  get 'posts/:id' => 'posts#show', as: "posts"
  post 'posts/create' => 'posts#create', as: "posts_create"
  get 'posts/:id/edit' => 'posts#edit', as: "posts_edit"
  post 'posts/:id/update' => 'posts#update', as: "posts_update"
  post 'posts/:id/destroy' => 'posts#destroy', as: "posts_destroy"

  post 'comments/:id/create' => 'comments#create', as: "comments_create"
  post 'comments/:id/destroy' => 'comments#destroy', as: "comments_destroy"

  get '/' => "home#top"


  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

end
