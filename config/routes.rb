Rails.application.routes.draw do
  resources :gamers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/rounds/create', to: 'rounds#create'
end
