class SessionsController < ApplicationController

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

def destroy
  session[:user_id] = nil
  redirect_to log_in_path, :notice => t(:logged_out)
end

end
