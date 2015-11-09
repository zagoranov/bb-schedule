Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root :to => "days#index" 

  resources :users do
    member do
      get 'blog'
    end  
    resources :profilecomments
    resources :notes
  end
  
  resources :sessions do
      collection do
        get 'form531'
        get 'load'        
        get 'statistics'
      end
  end

  resources :days do
      collection do
        get 'wholeweek'
        get 'bform531'
        post 'draw531'
        get 'graphs'
        post 'drawgraph'
        post 'purge'
        get 'archive'
        post 'emptyarchive'
      end
      member do
        post 'up'
        post 'down'
        post 'setarchive'
        post 'unarchive'
        post 'erase'
        get 'copy'
        get 'share'
        get 'unshare'                
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
    member do         
      post 'setarchive'
    end
  end

  resources :dictitems

  resources :notes  do
    resources :notecomments
  end

  resources :measurements 
  
  resources :friendships do
    member do         
      post 'wellhello'
      post 'byebye'
    end
  end

  resources :mealdishes do
    collection do
      get 'particdate'  
    end 
  end

  resources :dictnutrs


get "log_out" => "sessions#destroy", :as => "log_out"
get "log_in" => "sessions#new", :as => "log_in"
get "sign_up" => "users#new", :as => "sign_up"

post "drawgraph" => "days#drawgraph", :as => "drawgraph" , via: [:post]
post "draw531" => "days#draw531", :as => "draw531" , via: [:post]
get "calculate531" => "days#bform531", :as => "calculate531"
get "results531" => "sessions#form531", :as => "results531"

get "about" => "sessions#about", :as => "about"
get "aboutru" => "sessions#aboutru", :as => "aboutru"
get "faq" => "sessions#faq", :as => "faq"

match 'auth/:provider/callback', to: 'sessions#omnicreate', via: [:get, :post]
match 'auth/failure', to: redirect('/'), via: [:get, :post]

get 'change_locale', to: 'days#change_locale', as: :change_locale

get "loadthatshit" => "sessions#load", :as => "loadthatshit"

end

