Rails.application.routes.draw do


  devise_for :users
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html



  devise_scope :user do
    get "user/:id", :to => "users/registrations#detail"
    get "signup", :to => "users/registrations#new"
    post 'users/create' => 'users/registrations#create'
    get "login", :to => "users/sessions#new"
    post "login" => "users/sessions#create"
    post "logout", :to => "users/sessions#destroy"
  end

  post 'likes/:post_id/create' => 'likes#create'
  post 'likes/:post_id/destroy' => 'likes#destroy'

  # get 'signup' => 'users/registrations#new'
  # post 'login' => 'users/sessions#login'
  # post 'logout' => 'users/sessions#destroy'

  get 'users/index' => 'users#index'
  get 'users/new' => 'users#new'
  get 'users/follows' => 'users#follows'
  get 'users/search' => 'users#search'
  get 'users/:id' => 'users#show'
  # post 'users/create' => 'users/registrations#create'
  get 'users/:id/edit' => 'users#edit'
  post 'users/:id/update' => 'users#update'
  get 'users/:id/likes' => "users#likes"

  # get 'users/:id/followers' => 'users#followers'

  post 'relationships/:id/create' => 'relationships#create'
  post 'relationships/:id/destroy' => 'relationships#destroy'


  get 'posts/index' => 'posts#index'
  get 'posts/new' => 'posts#new'
  get 'posts/:id' => 'posts#show'
  post 'posts/create' => 'posts#create'
  get 'posts/:id/edit' => 'posts#edit'
  post 'posts/:id/update' => 'posts#update'
  post 'posts/:id/destroy' => 'posts#destroy'

  post 'comments/:id/create' => 'comments#create'
  post 'comments/:id/destroy' => 'comments#destroy'


  get '/' => 'home#top'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end


end
