Rails.application.routes.draw do

root :to => "sessions#new"  #"users#new"

  resources :users

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

   resources :trexercises 

   resources :trainings

   resources :sessions

get "log_out" => "sessions#destroy", :as => "log_out"
get "log_in" => "sessions#new", :as => "log_in"
get "sign_up" => "users#new", :as => "sign_up"

end
