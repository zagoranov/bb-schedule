Rails.application.routes.draw do

root :to => "users#new"

  resources :users

   resources :days do
      resources :exercises
   end

   resources :days do
      resources :trainings
   end

   resources :trainings
   resources :trexercises

   resources :sessions

get "log_out" => "sessions#destroy", :as => "log_out"
get "log_in" => "sessions#new", :as => "log_in"
get "sign_up" => "users#new", :as => "sign_up"

post "setmaxweight" => "trainings#setmaxweight", :as => "setmaxweight"

end
