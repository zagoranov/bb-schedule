class UsersController < ApplicationController

def new
  if current_user
    redirect_to days_path, :notice => t(:welcome_back)
  end 
  @user = User.new
end


def create
  @user = User.new(user_params)
  @user.admin = false
  if @user.save
     session[:user_id] = @user.id
     redirect_to root_path, :notice => t(:signed_up)
  else
    render "new"
  end
end


def index
  if params[:search]
    @users = User.search(params[:search]).order("created_at DESC")
  else
    @users = User.limit(30).order("RANDOM()")
  end
end


def show
 if current_user
    @user = User.find(params[:id])
    @activity = Training.joins(:day).where('user_id in (?)', @user).order('created_at DESC').limit(5)
    @shared = @user.days.where(shared2all: true).order(:number)
 else 
    redirect_to '/log_in'
 end
end


def edit
  @user = current_user
end


def update
  @user = User.find(params[:id])
  if @user.update(user_params)
    redirect_to @user
  else
    render 'edit'
  end
end


def current_admin
  current_user && current_user.admin
end


private
def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :notific)
  end
end
