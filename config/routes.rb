Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root :to => "days#index" 

  resources :users do
    resources :profilecomments
     end
  
  resources :sessions do
      member do
        get 'load'
      end
  end

  resources :days do
      collection do
        get 'wholeweek'
        get 'bform531'
        get 'aform531'        
      end
      member do
        get 'up'
        get 'down'
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
      get 'up'
      get 'down'            
    end
  end


  resources :trexercises  do
    member do
      get 'up'
      get 'down'            
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

get "loadthatshit" => "sessions#load", :as => "loadthatshit"

end

