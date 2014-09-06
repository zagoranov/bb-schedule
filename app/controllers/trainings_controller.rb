class TrainingsController < ApplicationController

def new
  day = Day.find(params[:day_id])
  @training = day.trainings.new
  day.exercises.each do |exer|  
     trexercise = @training.trexercises.new(title: exer.title, reps: exer.reps, maxweight: exer.maxweight)
     trexercise.save
  end
end


def show
  @training = Training.find(params[:id])
end


def create
    @training = Training.create(training_params)

 if @training.save
    redirect_to @training
  else
    render 'new'
  end
end


def edit
  @training = Training.find(params[:id])
end


def update
  @training = Training.find(params[:id])
  if @training.update(training_params)
    redirect_to @training
  else
    render 'edit'
  end
end



private
  def training_params
    params.require(:training).permit(:weight)
  end


end
