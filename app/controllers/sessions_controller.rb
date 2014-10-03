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

   #CONN.execute "DELETE from dictitems"  

   #CONN.execute "INSERT INTO dictitems ..."

 redirect_to root_path, :notice => t(:data_added)
 end
end



end
