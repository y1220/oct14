Rails.application.routes.draw do

  #  resources :photos
  #GET   /photos   photos#index  display a list of all photos
  #GET   /photos/new   photos#new  return an HTML form for creating a new photo
  #POST  /photos   photos#create   create a new photo
  #GET   /photos/:id   photos#show   display a specific photo
  #GET   /photos/:id/edit  photos#edit   return an HTML form for editing a photo
  #PATCH/PUT   /photos/:id   photos#update   update a specific photo
  #DELETE  /photos/:id   photos#destroy  delete a specific photo  get "meals/search" => "meals#search"





  #  get "meals/result" => "meals#result"


  # get "meals/search" => "meals#search"
  #  post "meals/create_s" => "meals#create_s"




  resources :users
  #resources :meals

  resources :meals do

    #member do

    #  end
    collection do

      get :search
      post :create_s
      get :result

    end

  end

  namespace :comments do
    get "/:id/reply" ,action: "reply"
    post "/:id/create_r" ,action: "create_r"
    get "/:id/edit" ,action:  "edit"
    post "/:id/update" ,action:  "update"
    post "/:id" ,action: "destroy"
  end




  get 'meal_types/assignment'
  get 'meals/:id/comments/new' => "comments#new"
  post "meals/:id/comments/create" => "comments#create"

  # get/post url => controller name #action

  get "login" => "users#login_form"
  post "login" => "users#login"

  post "logout" => "users#logout"


  #get 'users/index' => "users#index"
  #get 'signup' => "users#new"
  #get "users/:id" => "users#show"
  #post "users/create" => "users#create"

  #get "users/:id/edit" => "users#edit"
  #post "users/:id/update" => "users#update"



  #get 'meals/index' => "meals#index"
  # has to be above index to access correctly
  #get 'meals/new' => "meals#new"
  # has to be below index to access correctly



  #get 'meals/:id' => "meals#show"
  #post "meals/create" => "meals#create"
  #post "meals/:id/delete_image" => "meals#delete_image"
  #patch "meals/:id/edit" => "meals#edit"
  #get "meals/:id/edit" => "meals#edit"
  #patch "meals/:id/update" => "meals#update"
  #post "meals/:id/update" => "meals#update"

  #post "users/create_postman" => "users#create_postman"



  # post "meals/:id/destroy" => "meals#destroy"
  #post "users/:id/destroy" => "users#destroy"


  #get 'home/top'
  get '/' => "home#top"
  get 'about' => "home#about"




  namespace :api do

    get :status, to: 'api#status'

    #post :status, to: 'api#create_user'
    #get :login
    #post :login

    #resources :users
    #resources :meals, only:[:index, :show, :create]

    #collection routes -> no parameter
    #member routes
    resources :meals, only:[:show, :create] do
      #collection do
      get '/index', action: 'index' , on: :collection
      #end
    end
    get '/meal_name/:id', to: 'meals#show_name'
    get '/meal_user_name/:id', to: 'meals#show_name_of_user_and_meal'
    get '/show_name_serialize/:id', to: 'meals#show_name_serialize'
    get '/except_c_u/:id', to: 'meals#except_c_u'
    #get '/except_c_u_all', to: 'meals#except_c_u_all'

    get '/do_capitalized_title', to: 'meals#do_capitalized_title'

    get "/with_comments/:id", to: "meals#with_comments"

    #namespace :meals do
    # get '/', action: 'index'
    #  end

  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
