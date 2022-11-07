class MealdishesController < ApplicationController

respond_to :html, :js

def new
  @dictnutrs = Dictnutr.all.order(:title)
  @mealdish = Mealdish.new
end


def create
  mealdish = current_user.mealdishes.create(mealdish_params)
  meals = current_user.mealdishes.where('dt = ?', mealdish.dt).where('meal_n = ?', mealdish.meal_n)
  numb = meals.maximum("number")  
  if numb != nil
    mealdish.number = numb.to_i + 1
  else
    mealdish.number = 1
  end
  mealdish.save
  @ddate = mealdish.dt
  respond_to do |format|
    format.js { render partial: 'listrefresh'  }
    format.html { redirect_to "/mealdishes/particdate?date=" + @ddate.to_s }
  end
end

def particdate
  if current_user  
    session[:return_to] = "/mealdishes/particdate?date=" + params['date']
    @ddate = params['date'].to_date
    if (@ddate != nil)
      @meals = current_user.mealdishes.where('dt = ?', @ddate).order('meal_n, number')
      @dictnutrs = Dictnutr.all.order(:title)
    else
      render mealdishes_path 
    end
 else 
   redirect_to '/log_in'
 end  
end

def show
    redirect_to 'new'
end


def index
if current_user  
  session[:return_to] = mealdishes_path
  @calsanddates = Mealdish.joins(:dictnutr).select('dt, sum(mealdishes.doze * dictnutrs.calories) as cals, sum(mealdishes.doze * dictnutrs.fat) as fats, sum(mealdishes.doze * dictnutrs.protein) as prot, sum(mealdishes.doze * dictnutrs.carbs) as carb').where('mealdishes.user_id = ?', current_user.id).group('dt').order('dt DESC')
  @dictnutrs = Dictnutr.all.order(:title)
 else 
   redirect_to '/log_in'
 end  
end

def destroy
  meal = Mealdish.find(params[:id])
  @ddate = meal.dt
  meal.destroy
  respond_to do |format|
    format.js { render partial: 'listrefresh'  }
    format.html { redirect_to mealdishes_path }
  end
end


private
  def mealdish_params
    params.require(:mealdish).permit(:dictnutr_id, :meal_n, :dt, :doze)
  end

end
