# encoding: UTF-8
class SessionsController < ApplicationController

   CONN = ActiveRecord::Base.connection  #for sql_load

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


#def omnicreate
#    user = User.from_omniauth(env["omniauth.auth"])
#    session[:user_id] = user.id     
#    redirect_to root_url
#  end


def destroy
  session[:user_id] = nil
  redirect_to log_in_path, :notice => t(:logged_out)
end


def load  #sql loading stuff
 if current_user && current_user.admin
   CONN.execute "Update trainings set day_id = (select max(id) from days) where day_id is null"
   #CONN.execute "INSERT INTO dictitems ..."
   redirect_to root_path, :notice => t(:data_added)
 end
end


def about
  if I18n.locale == :ru
    redirect_to '/aboutru'
  end
end  

def aboutru
  if I18n.locale == :en
    redirect_to '/about'
  end
end  


def form531
  if params[:delt_max] == "" || params[:delt_reps]  == "" || params[:dead_max]  == "" || params[:dead_reps] == "" || params[:bench_max]  == "" || params[:bench_reps]  == "" || params[:sq_max] == "" || params[:sq_reps]  == "" 
    flash.now.alert = t(:need_more_info)
    render "days/bform531"
  end
end  

end
