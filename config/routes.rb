Rails.application.routes.draw do

  get "comments/:id/reply" => "comments#reply"
  post "comments/:id/create_r" => "comments#create_r"

  get 'meals/:id/comments/new' => "comments#new"
  post "meals/:id/comments/create" => "comments#create"
  get 'meal_types/assignment'
  # get/post url => controller name #action

  get "login" => "users#login_form"
  post "login" => "users#login"

  post "logout" => "users#logout"


  get 'users/index' => "users#index"
  get 'signup' => "users#new"
  get "users/:id" => "users#show"
  post "users/create" => "users#create"

  get "users/:id/edit" => "users#edit"
  post "users/:id/update" => "users#update"



  get 'meals/index' => "meals#index"
  # has to be above index to access correctly
  get 'meals/new' => "meals#new"
  # has to be below index to access correctly
  get 'meals/:id' => "meals#show"
  post "meals/create" => "meals#create"
  get "meals/:id/edit" => "meals#edit"
  post "meals/:id/update" => "meals#update"
  post "meals/:id/destroy" => "meals#destroy"
  post "users/:id/destroy" => "users#destroy"


  #get 'home/top'
  get '/' => "home#top"
  get 'about' => "home#about"



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
