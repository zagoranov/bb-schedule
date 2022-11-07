class TrainingsController < ApplicationController

respond_to :html, :js


def new
  if current_user  
    @day = Day.find(params[:day_id])
    @training = @day.trainings.new
  else 
    redirect_to '/log_in'
  end
end


def show
  if current_user  
    @training = Training.find(params[:id])
    @day = @training.day
    if @day.user != current_user
      redirect_to days_path
    end  
  else 
    redirect_to '/log_in'
  end
end


def create
 if current_user
    @day = Day.find(params[:day_id])
    @training = @day.trainings.create(training_params)
    @training.kind = @day.kind
    if @training.save
     @day.exercises.each do |exer|  
        trexercise = @training.trexercises.new(title: exer.title, reps: exer.reps, maxweight: exer.maxweight, number: exer.number, dictitem_id: exer.dictitem_id)
        trexercise.save
    end
      redirect_to edit_training_path(@training), :notice => t(:tr_created)
    else
      render 'new'
    end
  else 
    redirect_to '/log_in'
  end
end


def edit
  if current_user
    @training = Training.find(params[:id])
    @day = @training.day
    if @day.user != current_user
      redirect_to days_path
    end  
  else 
    redirect_to '/log_in'
  end
end


def update
  @training = Training.find(params[:id])
  if @training.update(training_params)
    #redirect_to day_trainings_path(@training.day)
    redirect_to :back
  else
    render 'edit'
  end
end


def index  # not using it
  if current_user
     @day = Day.find(params[:day_id])
     @trainings = @day.trainings.all
  else 
    redirect_to '/log_in'
  end
end


def destroy
  @training = Training.find(params[:id])
  @day = @training.day
  if @day.user == current_user
    @training.destroy
    redirect_to history_trainings_path, :notice => t(:tr_removed)
  end  
end

def history  # new index
  @trainings = Training.joins(:day).where('days.user_id = ? and trainings.archived = ?', current_user.id, false).order('trainings.created_at DESC').uniq
end


def setarchive
  tr = Training.find(params[:id])
  day = tr.day
  if day.user != current_user
    redirect_to days_path
  end    
  tr.archived = true
  tr.save
  @trainings = Training.joins(:day).where('days.user_id = ? and trainings.archived = ?', current_user.id, false).order('trainings.created_at DESC').uniq
  respond_to do |format|
    format.js { render partial: 'tr_list_refresh'  }
  end
end

private
  def training_params
    params.require(:training).permit(:weight, :info, :created_at, :kind)
  end

end
