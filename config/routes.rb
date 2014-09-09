Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root :to => "days#index"  #"users#new" 
#  root :to => "sessions#new"  #"users#new" 

  resources :users
  resources :sessions

  resources :days do
        collection do
            get 'wholeweek'
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

get "log_out" => "sessions#destroy", :as => "log_out"
get "log_in" => "sessions#new", :as => "log_in"
get "sign_up" => "users#new", :as => "sign_up"

end
