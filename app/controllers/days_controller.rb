class DaysController < ApplicationController

def new
  @day = Day.new
end


def create
 @user = User.find(current_user.id)
 @day = @user.days.create(day_params)

 if @day.save
    redirect_to @day
  else
    render 'new'
  end
end


def show
  @day = Day.find(params[:id])
end


def index
 if current_user
  @user = User.find(current_user.id)
  @days = @user.days.all
 else 
    redirect_to 'sign_in'
 end
end


def edit
  @day = Day.find(params[:id])
end


def update
  @day = Day.find(params[:id])
 
  if @day.update(day_params)
    redirect_to @day
  else
    render 'edit'
  end
end


def destroy
  @day = Day.find(params[:id])
  @day.destroy

  redirect_to days_path
end

private
  def day_params
    params.require(:day).permit(:title, :text)
  end

end
