class DaysController < ApplicationController

def new
  @day = Day.new
end


def create
 @user = User.find(current_user.id)
 @day = @user.days.create(day_params)
  days = @user.days.all
    numb = days.maximum("number")  
    if numb != nil
      @day.number = numb.to_i + 1
    else
      @day.number = 1
    end

 if @day.save
    redirect_to @day
  else
    render 'new'
  end
end


def show
  @day = Day.find(params[:id])
end


def wholeweek
  @user = User.find(current_user.id)
  @days = @user.days.order('number')
end


def index
 if current_user
  @user = User.find(current_user.id)
  @days = @user.days.order('number')
  @trainings = Training.joins(:day).where('days.user_id = ?', current_user.id).order('trainings.created_at').uniq
 else 
    redirect_to '/log_in'
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
    numb = @day.number
    if numb
      days = @day.user.days.where('number > ?', numb)
      days.each do |dy|
        dy.number = dy.number - 1
        dy.save
      end
    end
    @day.destroy
  redirect_to days_path
end


def up
  day = Day.find(params[:id])
  numb = day.number
  if numb > 1
    user = day.user
    day2 = user.days.find_by_number(numb - 1)
    if day2
      day2.number = numb
      day2.save
      day.number = numb - 1
      day.save
    end
  end
  redirect_to days_path
end

def down
  day = Day.find(params[:id])
  numb = day.number
  user = day.user
  day2 = user.days.find_by_number(numb + 1)
  if day2
    day2.number = numb
    day2.save
    day.number = numb + 1
    day.save
  end
  redirect_to days_path
end



private
  def day_params
    params.require(:day).permit(:title, :text)
  end

end
