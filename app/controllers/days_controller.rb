class DaysController < ApplicationController

respond_to :html, :js


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
  if @day.user != current_user && !@day.shared2all
    redirect_to days_path
  end  
end


def wholeweek
  @days = current_user.days.where.not(archived: true).order('number')
end


def index
 if current_user
   @days = @current_user.days.where.not(archived: true).order('number')
   @trainings = Training.joins(:day).where('days.user_id = ? and trainings.weight IS NOT NULL', current_user.id).order('trainings.created_at').uniq
   @activity = Training.joins(:day).where('user_id in (?)', current_user).order('created_at DESC').limit(3)
 else 
   redirect_to '/calculate531'  #'/log_in'
 end
end


def edit
  @day = Day.find(params[:id])
  if @day.user != current_user
    redirect_to days_path
  end  
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
  if @day.user == current_user
    if !@day.archived
      renumber(@day.number)
    end
    @day.destroy
    @archive_days = current_user.days.where(archived: true).order('created_at')
    respond_to do |format|
      format.js { render partial: 'archive_fresh'  }
    end
  end  
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
  respond_to do |format|
    format.js { render partial: 'listrefresh'  }
  end
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
  respond_to do |format|
    format.js { render partial: 'listrefresh'  }
  end
end


def setarchive
  day = Day.find(params[:id])
  if day.user == current_user  
    day.archived = true
    renumber(day.number)
    day.number = -1
    day.save
    respond_to do |format|
      format.js { render partial: 'listrefresh'  }
    end
  end  
end

def purge  
  current_user.days.update_all(archived: true)
  redirect_to days_path, :notice => t(:allpurged)
end

def archive
  if current_user  
    @archive_days = current_user.days.where(archived: true).where(erased: false).order('created_at')
  else 
    redirect_to '/log_in'
  end
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
  @archive_days = current_user.days.where(archived: true).where(erased: false).order('created_at')
  respond_to do |format|
    format.js { render partial: 'archive_fresh'  }
  end
end

def emptyarchive
  d_days = current_user.days.where(archived: true)  
  d_days.update_all(erased: true)
  redirect_to archive_days_path, :notice => t(:archiveempty)
end

def erase
  day = Day.find(params[:id])
  if day.user == current_user
    day.erased = true
    day.save
    @archive_days = current_user.days.where(archived: true).where(erased: false).order('created_at')
    respond_to do |format|
      format.js { render partial: 'archive_fresh'  }
    end
  end  
end



def share
  day = Day.find(params[:id])
  day.shared2all = true
  day.save
  redirect_to day, :notice => t(:day_shared)  
end

def unshare
  day = Day.find(params[:id])
  day.shared2all = false
  day.save
  redirect_to day, :notice => t(:day_unshared)  
end

def copy
  day = Day.find(params[:id])
    newday = current_user.days.create(title: day.title, text: day.text, kind: day.kind)
    if newday.save
       day.exercises.each do |exer|  
        exercise = newday.exercises.new(title: exer.title, reps: exer.reps, maxweight: exer.maxweight, number: exer.number, dictitem_id: exer.dictitem_id)
        exercise.save
       end 
    end
  redirect_to day, :notice => t(:day_copied)  
end




def change_locale
     if I18n.locale == :en
        I18n.locale = :ru
     else
        I18n.locale = :en
     end
  redirect_to :back, :notice => t(:locale_changed)
end



def graphs
  @trexers = Trexercise.joins(training: :day).where('days.user_id = ?', current_user.id).select("trexercises.title").order("trexercises.title").uniq
end

def drawgraph
  if params[:exer]
    @trexes_w2 = Trexercise.joins(training: :day).where('days.user_id = ? and trexercises.title = ? and trexercises.maxweight IS NOT NULL', current_user.id, params[:exer]).select('max(trexercises.maxweight) as maxw, trainings.created_at').group('trainings.created_at').order('trainings.created_at')
    respond_to do |format|
      format.js { render partial: 'graph_refresh'  }
    end
  end
end




def bform531  # form "before calculate 531"
  if current_user
      @days = current_user.days.where.not(archived: true).order('number')
  end
end

def draw531  #post
  respond_to do |format|
    format.js { render partial: 'draw_531'  }
  end
  if params[:movitmo].to_s == "true"
    aform531()
  end
end


private 
def aform531  # form "after calculate 531"
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
  sst_n = [3, 4, 1, 2]

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
      ss = t(:week)+ " " + i.to_s + ", " + t(:day) + " " + j.to_s + " (5/3/1)" 
      @day =   current_user.days.create({title: ss, text: d_type[j-1], number: max})
      max = max + 1
      e_max = 1
      
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

      if i < 4 && params['joker'].to_s == "true"   #JOKER
       for k in 0..2
         @day.exercises.create({title: d_type[j-1] + " ("+t(:joker_sets)+")", reps: joker_r[i-1][k], maxweight: round_w(((w_ms[j-1] / 100) * joker_w[i-1][k]).round, round_arr), dictitem_id: ids[j-1], number: e_max})
         e_max = e_max + 1
       end
      end        
      
      if i < 4 && params['pyramid'].to_s == "true"   #PYRAMID
       for k in 0..1
         @day.exercises.create({title: d_type[j-1] + " ("+t(:pyramid)+")", reps: pyr_r[i-1][k], maxweight: round_w(((w_ms[j-1] / 100) * pyr_w[i-1][k]).round, round_arr), dictitem_id: ids[j-1], number: e_max})
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

      if params['is_assist'].to_s == "true" && params['assist'].to_s == "sst"   #SST
       l = sst_n[j-1]    # веса берутся по другому порядку: if j=1 then l=3   j=2, l=4    j=3, l=1    j=4, l=2   
       for k in 0..2
         @day.exercises.create({title: sst1_type[j-1] + " ("+t(:simple_st)+")", reps: sst_r[z-1][k], maxweight: round_w(((w_ms[l-1] / 100) * sst_w[z-1][k]).round, round_arr), dictitem_id: sst1_ids[j-1], number: e_max})
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

      if params['is_assist'].to_s == "true" && (params['assist'].to_s == "bbb" || params['assist'].to_s == "bbbandch")  #BBB
        @day.exercises.create({title: d_type[j-1] + " ("+t(:bigbutboring)+")", reps: '5x10', maxweight: round_w(((w_ms[j-1] / 100) * 50).round, round_arr), dictitem_id: ids[j-1], number: e_max })
        e_max = e_max + 1
        @day.exercises.create({title: bbb_type[j-1] + " ("+t(:bigbutboring)+")", reps: '5x10', maxweight: nil, dictitem_id: bbb_ids[j-1], number: e_max })
      end

      if params['is_assist'].to_s == "true" && (params['assist'].to_s == "ch_f_sch" || params['assist'].to_s == "bbbandch")  #Fill from day in schedule!!!
        s = 'day'+j.to_s
        if params[s] != "" && Day.find(params[s])
          day = Day.find(params[s])
          day.exercises.order("number").each do |exer| 
           @day.exercises.create({title: exer.title, reps: exer.reps, maxweight: exer.maxweight, dictitem_id: exer.dictitem_id, number: e_max })
           e_max = e_max + 1
          end
        end 
      end 

    end
  end
#  redirect_to days_path, :notice => t(:created531)
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
    params.require(:day).permit(:title, :text, :kind)
  end

end

