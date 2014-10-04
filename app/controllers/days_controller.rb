class DaysController < ApplicationController

def new
  @day = Day.new
end

def create
 @day = current_user.days.create(day_params)
    numb = current_user.days.maximum("number")
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
  @days = current_user.days.where.not(archived: true).order('number')
end


def index
 if current_user
   @days = @current_user.days.where.not(archived: true).order('number')
   @trainings = Training.joins(:day).where('days.user_id = ? and trainings.weight IS NOT NULL', current_user.id).order('trainings.created_at').uniq
 else 
   redirect_to '/calculate531'  #'/log_in'
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
  if !@day.archived
    renumber(@day.number)
  end
  @day.destroy
  redirect_to archive_days_path, :notice => t(:destroyedone)
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


def setarchive
  day = Day.find(params[:id])
  day.archived = true
  renumber(day.number)
  day.number = -1
  day.save
  redirect_to days_path, :notice => t(:onepurged)
end

def purge
  current_user.days.update_all(archived: true)
  redirect_to days_path, :notice => t(:allpurged)
end

def archive
  @archive_days = current_user.days.where(archived: true).order('created_at')
end

def unarchive
  day = Day.find(params[:id])
  day.archived = false
  max = current_user.days.maximum("number")
  if max 
    day.number = max + 1
  else
    day.number = 1
  end
  day.save
  redirect_to archive_days_path, :notice => t(:dayrestored)
end

def emptyarchive
  d_days = current_user.days.where(archived: true)  
  d_days.destroy_all
  redirect_to archive_days_path, :notice => t(:archiveempty)
end

def change_locale
     if I18n.locale == :en
        I18n.locale = :ru
     else
        I18n.locale = :en
     end
  redirect_to :back, :notice => t(:locale_changed)
end


def bform531  # before
  #redirect_to days_path
end

def aform531  #after
 if params[:delt_max] == "" || params[:delt_reps]  == "" || params[:dead_max]  == "" || params[:dead_reps] == "" || params[:bench_max]  == "" || params[:bench_reps]  == "" || params[:sq_max] == "" || params[:sq_reps]  == "" 
    flash.now.alert = t(:need_more_info)
    render "bform531"
 else
  d_type = [t(:ov_press), t(:deadlift), t(:bench_press), t(:squats)]
  bbb_type = [t(:chinups), t(:hang_leg), t(:dumb_row), t(:leg_curl)]
  
  sst1_type = [t(:close_press), t(:front_squat), t(:incline_press), t(:sl_deadlift)]
  sst2_type = [[t(:lats), t(:upper_back), t(:triceps), t(:biceps)], [t(:hamstrings), t(:lower_back), t(:abs)]]

  if Rails.env.production?  
    ids = [164, 192, 203, 252]      #server
    bbb_ids = [178, 245, 184, 257]  #server
    sst1_ids = [210, 251, 200, 199]
  else
    ids = [1268, 1296, 1309, 1356]      #local
    bbb_ids = [1282, 1349, 1288, 1361]  #local
    sst1_ids = [1314, 1355, 1304, 1303]
  end 
  warm_p = [40, 50, 60]
  weights = [[65, 75, 85], [70, 80, 90], [75, 85, 95], [40, 50, 60]]
  reps = [['5', '5', '5+'], ['3', '3', '3+'], ['5', '3', '1+'], ['5', '5', '5']]
  pyr_w = [[75, 65], [80, 70], [85, 75]]
  pyr_r = [['5', '5+'], ['3', '3+'], ['3', '5+']]
  joker_w = [[95, 105, 110], [100, 105, 115], [105, 115, 120]]
  joker_r = [['5', '5', '2'], ['3', '5', '1'], ['1', '1', '1']]
  fsl_w = [65, 70, 75] 
  fslms_w = [65, 70, 75]  
  sst_w = [[50, 60, 70], [60, 70, 80], [65, 75, 85], [40, 50, 60]]
  sst_r = [['10', '10', '10'], ['8', '8', '6'], ['5', '5', '5'], ['5', '5', '5']]

  w_ms = Array.new(4)
  w_ms[0] = get_workin_max(params[:delt_max], params[:delt_reps]) 
  w_ms[1] = get_workin_max(params[:dead_max], params[:dead_reps]) 
  w_ms[2] = get_workin_max(params[:bench_max], params[:bench_reps]) 
  w_ms[3] = get_workin_max(params[:sq_max], params[:sq_reps]) 
  if params['shrink'].to_s == "true"
    round_arr = ['0', '2', '5', '7']
  else
    round_arr = ['0', '5']
  end
  max = current_user.days.maximum("number")
  if max != nil
    max = max + 1
  else
    max = 1
  end
  if params['threewks'].to_s == "true"
    n = 3
  else
    n = 4
  end

  for i in 1..n
    for j in 1..4
      @day =   current_user.days.create({title: t(:day)+ ' ' +j.to_s+', '+t(:week)+' '+i.to_s+' (5/3/1)', text: d_type[j-1], number: max})
      max = max + 1
      e_max = 0      
      
      if params['warmup'].to_s == "true" #WARM UP
        for k in 0..2
          rps = '5'
          if k==2 
            rps = '3'
          end
          @day.exercises.create({title: d_type[j-1] + " ("+t(:warm_up)+")", reps: rps, maxweight: round_w(((w_ms[j-1] / 100) * warm_p[k]).round, round_arr), dictitem_id: ids[j-1], number: e_max})
          e_max = e_max + 1
        end
      end

      z = i
      if params['pwrlift'].to_s == "true" && i < 3
        z = 3 - i
      end  
      for k in 0..2   #BASE 5/3/1    +      POWERLIFTING 3/5/1
        @day.exercises.create({title: d_type[j-1], reps: reps[z-1][k], maxweight: round_w(((w_ms[j-1] / 100) * weights[z-1][k]).round, round_arr), dictitem_id: ids[j-1], number: e_max })
        e_max = e_max + 1
      end
      
      if i < 4 && params['pyramid'].to_s == "true"   #PYRAMID
       for k in 0..1
         @day.exercises.create({title: d_type[j-1] + " ("+t(:pyramid)+")", reps: pyr_r[i-1][k], maxweight: round_w(((w_ms[j-1] / 100) * pyr_w[i-1][k]).round, round_arr), dictitem_id: ids[j-1], number: e_max})
         e_max = e_max + 1
       end
      end        

      if i < 4 && params['joker'].to_s == "true"   #JOKER
       for k in 0..2
         @day.exercises.create({title: d_type[j-1] + " ("+t(:joker_sets)+")", reps: joker_r[i-1][k], maxweight: round_w(((w_ms[j-1] / 100) * joker_w[i-1][k]).round, round_arr), dictitem_id: ids[j-1], number: e_max})
         e_max = e_max + 1
       end
      end        

      if i < 4 && params['fsl'].to_s == "true"   #FIRTS SET LAST
        @day.exercises.create({title: d_type[j-1] + " ("+t(:firts_set_last)+")", reps: t(:amrap), maxweight: round_w(((w_ms[j-1] / 100) * fsl_w[i-1]).round, round_arr), dictitem_id: ids[j-1], number: e_max})
        e_max = e_max + 1
      end        

      if i < 4 && params['fslms'].to_s == "true"   #FIRTS SET LAST - MULTIPLE SETS
        @day.exercises.create({title: d_type[j-1] + " ("+t(:firts_set_last_ms)+")", reps: '3-5x5-8', maxweight: round_w(((w_ms[j-1] / 100) * fslms_w[i-1]).round, round_arr), dictitem_id: ids[j-1], number: e_max})
        e_max = e_max + 1
      end        

      if params['assist'].to_s == "sst"   #SST
       for k in 0..2
         @day.exercises.create({title: sst1_type[j-1] + " ("+t(:simple_st)+")", reps: sst_r[z-1][k], maxweight: round_w(((w_ms[j-1] / 100) * sst_w[z-1][k]).round, round_arr), dictitem_id: sst1_ids[j-1], number: e_max})
         e_max = e_max + 1
       end
       if j == 2 || j == 4
         jj = 1
         nn = 2
       else
         jj = 0
         nn = 3
       end
       for k in 0..nn
         @day.exercises.create({title: sst2_type[jj][k] + " ("+t(:simple_st)+")", reps: '3x10-20', maxweight: nil, dictitem_id: nil, number: e_max})
         e_max = e_max + 1
       end
      end        

      if params['assist'].to_s == "bbb"   #BBB
        @day.exercises.create({title: d_type[j-1] + " ("+t(:bigbutboring)+")", reps: '5x10', maxweight: round_w(((w_ms[j-1] / 100) * 50).round, round_arr), dictitem_id: ids[j-1], number: e_max })
        e_max = e_max + 1
        @day.exercises.create({title: bbb_type[j-1] + " ("+t(:bigbutboring)+")", reps: '5x10', maxweight: nil, dictitem_id: bbb_ids[j-1], number: e_max })
      end
    end
  end
  redirect_to days_path, :notice => t(:created531)
 end
end


def graphs
  @trexers = Trexercise.joins(training: :day).where('days.user_id = ?', current_user.id).select("trexercises.title").uniq
  if params[:exer]
    @trexes_w2 = Trexercise.joins(training: :day).select('max(trexercises.maxweight) as maxweight, trexercises.created_at, trainings.created_at').where('days.user_id = ? and trexercises.title = ? and trexercises.maxweight IS NOT NULL', current_user.id, params[:exer]).group('trainings.created_at').order('trexercises.created_at')
  end
end



private
 def renumber(numb)
    if numb
      days = current_user.days.where('number > ?', numb)
      days.each do |dy|
        dy.number = dy.number - 1
        dy.save
      end
    end
 end


private
  def day_params
    params.require(:day).permit(:title, :text)
  end



end


