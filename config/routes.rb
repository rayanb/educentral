Rails.application.routes.draw do

 root 'welcome#index'
 get '/tracks.json', :to => 'tracks#json'
 resources :users
 resources :sessions, only: [:new, :create, :destroy]
 resources :categories, only: [:index, :show] do
  get '/tracks/new.json', :to => 'tracks#new_json'
  resources :tracks, only: [:new, :create]
 end

 resources :courses do
  resources :reviews
  post '/check', :to => 'courses#check'
  post '/uncheck', :to => 'courses#uncheck'
end

 resources :tracks, except: [:new, :create] do
   resources :courses, only: [:index, :destroy]
   post '/follow', :to => 'tracks#follow'
   post '/fork', :to => 'tracks#fork'
 end

  get 'auth/google_oauth2/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

end