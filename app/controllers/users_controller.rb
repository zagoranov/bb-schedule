class UsersController < ApplicationController

def new
  if current_user
    redirect_to days_path, :notice => t(:welcome_back)
  end 
  @user = User.new
end


def create
  @user = User.new(user_params)
  if @user.save
     session[:user_id] = @user.id
     redirect_to root_path, :notice => t(:signed_up)
  else
    render "new"
  end
end


def index
 if current_user
  @users = User.all
 else 
    redirect_to '/log_in'
 end
end

def show
 if current_user
    @user = User.find(params[:id])
 else 
    redirect_to '/log_in'
 end
end


private
def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
