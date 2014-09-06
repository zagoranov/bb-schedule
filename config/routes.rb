Rails.application.routes.draw do

root :to => "users#new"

  resources :users
    resources :days do
      resources :exercises
      resources :trainings do
         resources :trexercises
     end
  end

resources :sessions

get "log_out" => "sessions#destroy", :as => "log_out"
get "log_in" => "sessions#new", :as => "log_in"
get "sign_up" => "users#new", :as => "sign_up"

end
