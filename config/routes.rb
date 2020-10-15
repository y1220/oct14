Rails.application.routes.draw do
  get 'meals/index' => "meals#index"
  # has to be below index to access correctly
  get 'meals/:id' => "meals#show"
  #get 'home/top'
  get '/' => "home#top"
  get 'about' => "home#about"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
