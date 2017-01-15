Rails.application.routes.draw do
  resources :gamers
  root :to => "rounds#new"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/rounds/new', to: 'rounds#new'
end
