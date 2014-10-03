# encoding: UTF-8
class SessionsController < ApplicationController

  CONN = ActiveRecord::Base.connection

def new
  if current_user
    redirect_to days_path, :notice => t(:welcome_back)
  end 
end

def create
  user = User.authenticate(params[:email], params[:password])
  if user
    session[:user_id] = user.id
    redirect_to root_path, :notice => t(:logged_in)
  else
    flash.now.alert = t(:invalid_user)
    render "new"
  end
end


def omnicreate
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id     
    redirect_to root_url
  end


def destroy
  session[:user_id] = nil
  redirect_to log_in_path, :notice => t(:logged_out)
end


def load
 if current_user && current_user.admin
 #164, 192, 203, 252
 #bbb_ids = [178, 245, 184, 257

 CONN.execute "Update dictitems set url = 'http://www.bodybuilding.com/exercises/detail/view/name/standing-military-press', name = 'Shoulders - Standing Military Press', description = '' where id = 164"
 CONN.execute "Update dictitems set url = 'http://www.bodybuilding.com/exercises/detail/view/name/barbell-deadlift', name = 'Back - Barbell Deadlift', description = '' where id = 192"
 CONN.execute "Update dictitems set url = 'http://www.bodybuilding.com/exercises/detail/view/name/barbell-bench-press-medium-grip', name = 'Chest - Barbell Bench Press', description = '' where id = 203"
 CONN.execute "Update dictitems set url = 'http://www.bodybuilding.com/exercises/detail/view/name/barbell-squat', name = 'Legs - Barbell Squat', description = '' where id = 252"

 CONN.execute "Update dictitems set url = 'http://www.bodybuilding.com/exercises/detail/view/name/chin-up', name = 'Back - Chin-Ups', description = '' where id = 178"
 CONN.execute "Update dictitems set url = 'http://www.bodybuilding.com/exercises/detail/view/name/hanging-leg-raise', name = 'Abs - Hanging Leg Raise', description = '' where id = 245"
 CONN.execute "Update dictitems set url = 'http://www.bodybuilding.com/exercises/detail/view/name/one-arm-dumbbell-row', name = 'Back - One Arm Dumbbell Row', description = '' where id = 184"
 CONN.execute "Update dictitems set url = 'http://www.bodybuilding.com/exercises/detail/view/name/lying-leg-curls', name = 'Legs - Lying Leg Curls', description = '' where id = 257"

 redirect_to root_path, :notice => t(:data_added)
 end
end



end
