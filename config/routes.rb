Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root :to => "days#index" 

  resources :users do
    resources :profilecomments
     end
  
  resources :sessions do
      collection do
        get 'form531'
      end
      member do
        get 'load'
      end
  end

  resources :days do
      collection do
        get 'wholeweek'
        get 'bform531'
        get 'aform531'
        get 'graphs'
        post 'draw_graph'
        post 'purge'
        get 'archive'
        post 'emptyarchive'
      end
      member do
        post 'up'
        post 'down'
        post 'setarchive'
        post 'unarchive'
      end
      resources :exercises
  end

  resources :days do
    resources :trainings do
      resources :trexercises
    end   
  end

  resources :exercises do
    member do
      post 'up'
      post 'down'            
    end
  end


  resources :trexercises  do
    member do
      post 'up'
      post 'down'            
    end
  end

  resources :trainings do
        collection do
            get 'history'
         end
  end

  resources :dictitems

  resources :friendships


get "log_out" => "sessions#destroy", :as => "log_out"
get "log_in" => "sessions#new", :as => "log_in"
get "sign_up" => "users#new", :as => "sign_up"

get "calculate531" => "days#bform531", :as => "calculate531"
get "results531" => "sessions#form531", :as => "results531"

get "about" => "sessions#about", :as => "about"
get "aboutru" => "sessions#aboutru", :as => "aboutru"

match 'auth/:provider/callback', to: 'sessions#omnicreate', via: [:get, :post]
match 'auth/failure', to: redirect('/'), via: [:get, :post]

get 'change_locale', to: 'days#change_locale', as: :change_locale

get "loadthatshit" => "sessions#load", :as => "loadthatshit"

end

