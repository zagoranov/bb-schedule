class TrainingsController < ApplicationController

def new
  @day = Day.find(params[:format])
  @training = @day.trainings.new
  @day.exercises.each do |exer|  
     trexercise = @training.trexercises.new(title: exer.title, reps: exer.reps, maxweight: exer.maxweight)
     trexercise.save
  end
end


def show
  @training = Training.find(params[:id])
end


def create
#    @training = Training.create(training_params)
     @training = @day.training.new(params[:training])

 if @training.save
#    redirect_to @training
     format.html { redirect_to [@day, @training], notice: 'Trainig was successfully created.' }
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


def index
  @user = User.find(current_user.id)
  @days = @user.days.all
  @trainings = @days.trainings.all
#  @trainings = Day.trainings.all.where(user_id: current_user.id)

end


private
  def training_params
    params.require(:training).permit(:weight)
  end


end
