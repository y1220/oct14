Rails.application.routes.draw do
  get 'meals/index' => "meals#index"
  # has to be above index to access correctly
  get 'meals/new' => "meals#new"
  # has to be below index to access correctly
  get 'meals/:id' => "meals#show"
  post "meals/create" => "meals#create"
  get "meals/:id/edit" => "meals#edit"
  post "meals/:id/update" => "meals#update"
  post "meals/:id/destroy" => "meals#destroy"


  #get 'home/top'
  get '/' => "home#top"
  get 'about' => "home#about"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
