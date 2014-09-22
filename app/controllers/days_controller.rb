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

def bform531  # before
  #redirect_to days_path
end

def aform531  #after
  user = User.find(current_user.id)

  d_type = [t(:ov_press), t(:deadlift), t(:bench_press), t(:squats)]
  bbb_type = [t(:chinups), t(:hang_leg), t(:dumb_row), t(:leg_curl)]
#  ids = [1268, 1296, 1309, 1356]      #locale
#  bbb_ids = [1282, 1349, 1288, 1361]  #locale
  ids = [34, 110, 68, 117]      #server
  bbb_ids = [48, 110, 54, 123]  #server
  warm_p = [40, 50, 60]
  weights = [[65, 75, 85], [70, 80, 90], [75, 85, 95], [40, 50, 60]]
  reps = [['5', '5', '5+'], ['3', '3', '3+'], ['5', '3', '1+'], ['5', '5', '5']]
  w_ms = Array.new(4)
  w_ms[0] = get_workin_max(params[:delt_max], params[:delt_reps]) 
  w_ms[1] = get_workin_max(params[:dead_max], params[:dead_reps]) 
  w_ms[2] = get_workin_max(params[:bench_max], params[:bench_reps]) 
  w_ms[3] = get_workin_max(params[:sq_max], params[:sq_reps]) 
  
  if params['threewks'].to_s == "true"
    n = 3
  else
    n = 4
  end

  for i in 1..n
    for j in 1..4
      @day = user.days.create({title: t(:day)+ ' ' +j.to_s+', '+t(:week)+' '+i.to_s+' (5/3/1)', text: d_type[j-1]}) 
      for k in 0..2
        rps = '5'
        if k==2 
          rps = '3'
        end
        @day.exercises.create({title: d_type[j-1] + " ("+t(:warm_up)+")", reps: rps, maxweight: round_w(((w_ms[j-1] / 100) * warm_p[k]).round), dictitem_id: ids[j-1] })
      end
    
      for k in 0..2
        @day.exercises.create({title: d_type[j-1], reps: reps[i-1][k], maxweight: round_w(((w_ms[j-1] / 100) * weights[i-1][k]).round), dictitem_id: ids[j-1] })
      end

      if params['bbb'].to_s == "true"
        @day.exercises.create({title: d_type[j-1] + " ("+t(:bigbutboring)+")", reps: '5 x 10', maxweight: round_w(((w_ms[j-1] / 100) * 50).round), dictitem_id: ids[j-1] })
        @day.exercises.create({title: bbb_type[j-1] + " ("+t(:bigbutboring)+")", reps: '5 x 10', maxweight: nil, dictitem_id: bbb_ids[j-1] })
      end
    end
  end
  redirect_to days_path
end


private
  def day_params
    params.require(:day).permit(:title, :text)
  end

private
def get_workin_max(max, reps)
  delta_1 = max.to_f * reps.to_i * 0.03333 + max.to_f
  return (delta_1 / 100) * 90  
end

private
def round_w(weight)
  delta_90 = weight
  while (!['0', '2', '5', '7'].include? delta_90.to_s.last )
    delta_90 = delta_90 - 1
  end
  return delta_90
end


end


