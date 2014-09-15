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
  if params[:search]
    @users = User.search(params[:search]).order("created_at DESC")
  else
    @users = User.all.order('created_at DESC')
  end
end


def show
 if current_user
    @user = User.find(params[:id])
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


private
def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
