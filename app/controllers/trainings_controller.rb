class TrainingsController < ApplicationController


def new
  @day = Day.find(params[:day_id])
  @training = @day.trainings.new
end


def show
  @training = Training.find(params[:id])
  @day = Day.find(@training.day)
end


def create
   @day = Day.find(params[:day_id])
   @training = @day.trainings.create(training_params)

   if @training.save
     @day.exercises.each do |exer|  
        trexercise = @training.trexercises.new(title: exer.title, reps: exer.reps, maxweight: exer.maxweight)
        trexercise.save
     end
     redirect_to edit_training_path(@training)
   else
     render 'new'
  end
end


def edit
  @training = Training.find(params[:id])
  @day = @training.day
end


def update
  @training = Training.find(params[:id])
  if @training.update(training_params)
    redirect_to day_trainings_path(@training.day)
  else
    render 'edit'
  end
end


def index
   @day = Day.find(params[:day_id])
   @trainings = @day.trainings.all
end


def destroy
  @training = Training.find(params[:id])
  @day = @training.day
  @training.destroy
  redirect_to day_trainings_path(@day)
end


private
  def training_params
    params.require(:training).permit(:weight, :info)
  end

end
